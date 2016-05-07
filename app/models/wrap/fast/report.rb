module Wrap
  class Fast::Report < Wrap::Report
    def save_output
      Identifier::Enigma.new(@g.id).decode_file(@run.path_to_output)

      TextFile.create(
        file:         File.open(@run.path_to_output),
        meta:         "output",
        textifilable: @run_report)
    end
  end
end
