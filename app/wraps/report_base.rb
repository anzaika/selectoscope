class ReportBase
  def initialize(run)
    @run = run
    @v = run.v
    @g = run.g
  end

  def save
    create_run_report
    save_output if run_successful?
    clear_temp_files
  end

  def run_successful?
    @run_successful ||=
      FileTest.exist?(@run.path_to_output) &&
      FileTest.exist?(@v.path_to_stdout) &&
      FileTest.exist?(@v.path_to_stderr)
  end

  private

  def create_run_report
    save_run_report
    decode_out_files
    save_out_files
  end

  def decode_out_files
    enigma = Identifier::Enigma.new(@g.id)
    enigma.decode_file(@v.path_to_stdout)
    enigma.decode_file(@v.path_to_stderr)
  end

  def save_out_files
    TextFile.create(file:         File.open(@v.path_to_stdout),
                    meta:         "stdout",
                    textifilable: @run_report)

    TextFile.create(file:         File.open(@v.path_to_stderr),
                    meta:         "stderr",
                    textifilable: @run_report)
  end

  def save_run_report
    @run_report =
      RunReport.create(
        directory_snapshot: @v.file_list,
        program:            @run.class::PROGRAM,
        exec:               @run.class::EXEC,
        version:            @run.version,
        params:             @run.args,
        successful:         run_successful?
      )
    @g.run_reports << @run_report
  end

  def clear_temp_files
    @v.destroy
  end
end