class ReportBase
  def initialize(run, profile_report)
    @run = run
    @v = run.v
    @profile_report = profile_report
  end

  def save
    create_tool_report
    @tool_report.decode_all_text_files
    save_tool_results if run_successful?
    clear_temp_files
    @tool_report
  end

  def run_successful?
    @run_successful ||=
      FileTest.exist?(@run.path_to_output) &&
      FileTest.exist?(@v.path_to_stdout) &&
      FileTest.exist?(@v.path_to_stderr)
  end

  private

  def create_tool_report
    save_tool_report
    save_stdout_files
  end

  def save_stdout_files
    TextFile.create(file:         File.open(@v.path_to_stdout),
                    meta:         "stdout",
                    textifilable: @tool_report)

    TextFile.create(file:         File.open(@v.path_to_stderr),
                    meta:         "stderr",
                    textifilable: @tool_report)
  end

  def save_tool_report
    @tool_report =
      ToolReport.new(
        directory_snapshot: @v.file_list,
        program:            @run.class::PROGRAM,
        exec:               @run.class::EXEC,
        version:            @run.version,
        params:             @run.args,
        successful:         run_successful?,
        tool_id:            tool_id,
        profile_report:     @profile_report
      )
  end

  def clear_temp_files
    @v.destroy
  end
end
