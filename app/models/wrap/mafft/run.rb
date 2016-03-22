module Wrap
class Mafft::Run < Wrap::Run

  PROGRAM = "MAFFT"
  EXEC = "mafft-linsi"
  FASTA = "fasta.fasta"
  OUTPUT = "output.out"

  def version
    ''
  end

  def args
    @args ||= "#{@v.path_to(FASTA)} > #{@v.path_to(OUTPUT)}"
  end

  def setup_files
    @v.add(@g.fasta_file.file.path, FASTA)
  end

end
end
