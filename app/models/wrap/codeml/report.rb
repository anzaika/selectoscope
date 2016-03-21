module Wrap
class Codeml::Report
  def initialize(run)
    @run = run
    @v = run.v
    @g = run.g
  end

  def save
    create_run_report
    create_codeml_result if run_successful?
    clear_temp_files
  end

  def run_successful?
    @run_successful ||=
      FileTest.exist?(@run.path_to_output) &&
      FileTest.exist?(@v.path_to('stdout.out')) &&
      FileTest.exist?(@v.path_to('stderr.out'))
  end

  private

  def create_run_report
    save_out_files
    save_run_report
    @run_report.text_files << @stdout
    @run_report.text_files << @stderr
  end

  def save_out_files
    @stdout = TextFile.create(file: File.open(@v.path_to('stdout.out')))
    @stderr = TextFile.create(file: File.open(@v.path_to('stderr.out')))
  end

  def save_run_report
    @run_report =
      RunReport.create(
        directory_snapshot: @v.file_list,
        program: Codeml::Run::EXEC,
        params: @run.args,
        successful: run_successful?)
    @g.run_reports << @run_report
  end

  def create_codeml_result
    output = TextFile.create(file: File.open(@run.path_to_output))
    @codeml_result = CodemlResult.create(text_file: output)

    @g.codeml_result.destroy if @g.codeml_result
    @g.codeml_result = @codeml_result
  end

  def clear_temp_files
    @v.destroy
  end
end
end
