module Codeml
  class Report < ReportBase
    def save_output
      Identifier::Enigma.new(@g.id).decode_file(@run.path_to_output)

      codeml_result = CodemlResult.create

      TextFile.create(
        file:         File.open(@run.path_to_output),
        meta:         "codeml_output",
        textifilable: codeml_result
      )

      codeml_result.process_output

      @g.codeml_result.destroy if @g.codeml_result
      @g.codeml_result = codeml_result
    end
  end
end
