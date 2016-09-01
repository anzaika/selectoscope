module Codeml
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

      codeml_result = CodemlResult.create

      TextFile.create(
        file:         File.open(@run.path_to_output),
        meta:         "codeml_output",
        textifilable: @tool_report
      )

      TextFile.create(
        file:         File.open(@run.path_to_output),
        meta:         "codeml_output",
        textifilable: codeml_result
      )

      codeml_result.process_output
      @profile_report.codeml_result = codeml_result
      @profile_report.save
    end
  end
end
