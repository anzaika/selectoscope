module Fastcodeml
  class Report < ReportBase

    def tool_id
      @profile_report.tool_for_selection.id
    end

    def run_successful?
      @run_successful ||=
        FileTest.exist?(@run.path_to_output) &&
        FileTest.exist?(@v.path_to_stdout) &&
        FileTest.exist?(@v.path_to_stderr)
    end

    def save_tool_results
      @profile_report.group.enigma.decode_file(@run.path_to_output)

      TextFile.create(
        file:         File.open(@run.path_to_output),
        meta:         "output",
        textifilable: @tool_report
      )

      FastResult.create(profile_report: @profile_report)
    end
  end
end
