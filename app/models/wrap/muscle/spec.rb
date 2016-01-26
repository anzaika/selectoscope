module Wrap::Muscle
class Spec
  OUTPUT_FILENAME = 'seqs'

  attr_reader :result_path, :dir

  # @param fasta [String] sequences in multiple-fasta format
  def initialize(fasta:)
    @sequences = fasta
    @dir       = Dir.mktmpdir

    @seq_path    = File.join(@dir, 'sequences.fa')
    @result_base_path = File.join(@dir, OUTPUT_FILENAME)
  end

  def create_files
    File.open(@seq_path,'w'){|f| f << @sequences}
  end

  def result_path
    @result_base_path + '.afa'
  end

  def arguments
    "-in #{@seq_path} " +
    "-out #{result_path}"
  end

  def unlink
    FileUtils.remove_entry(@dir)
  end

end
end
