module Wrap
class Fast::Report < Wrap::Report

  def save_output
    Identifier::Enigma.new(@g.id).decode_file(@run.path_to_output)

    output =
      TextFile.create(
        file: File.open(@run.path_to_output),
        meta: 'fast_output')

    @fast_result = FastResult.create(text_file: output)

    @g.fast_result.destroy if @g.fast_result
    @g.fast_result = @fast_result
  end

end
end
