module Wrap
class Gblocks::Report < Wrap::Report

  def save_output
    fasta_file = FastaFile.create(file: File.open(@run.path_to_output))
    alignment = Alignment.create(meta: 'processed', fasta_file: fasta_file)
    @g.alignments << alignment
  end

end
end
