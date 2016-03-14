module Wrap
class Mafft::Run

  attr_reader :args, :path_to_output

  EXEC = "mafft-linsi"
  ALIGNMENT = "aligned.fasta"

  def initialize(vault, fasta_file_object)
    @v = vault
    @ff = fasta_file_object
  end

  def execute
    setup_files
    run
  end

  def path_to_alignment
    @path_to_output ||= @v.path_to(ALIGNMENT)
  end

  def args
    @args ||= "#{@v.path_to('sequences.fasta')} > #{path_to_alignment}"
  end

  private

  def setup_files
    @v.add(@ff.file, 'sequences.fasta')
  end

  def run
    @v.run(EXEC, args)
  end

end
end
