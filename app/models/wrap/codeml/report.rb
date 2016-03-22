module Wrap
class Codeml::Report < Wrap::Report

  def save_output
    Identifier::Enigma.new(@g.id).decode_file(@run.path_to_output)

    output =
      TextFile.create(
        file: File.open(@run.path_to_output),
        meta: 'codeml_output')

    @codeml_result = CodemlResult.create(text_file: output)

    @g.codeml_result.destroy if @g.codeml_result
    @g.codeml_result = @codeml_result
  end

end
end
