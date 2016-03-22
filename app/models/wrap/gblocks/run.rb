module Wrap
class Gblocks::Run < Wrap::Run

  EXEC = "Gblocks"
  ALIGNMENT = "sequences.fa"
  OUTPUT = "sequences.fa-gb"

  def args
    @args ||= "#{@v.path_to(ALIGNMENT)} -t=c"
  end

  def setup_files
    @v.add(@g.alignments.original.first.fasta_file.file.path, ALIGNMENT)
  end

end
end
