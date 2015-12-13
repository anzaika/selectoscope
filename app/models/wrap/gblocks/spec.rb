module Wrap::Gblocks
class Spec
  attr_reader :result_path

  def initialize(fasta:)
    @sequences = fasta
    @dir       = Dir.mktmpdir

    @seq_path    = File.join(@dir, 'sequences.fa')
    @result_path = File.join(@dir, 'sequences.fa-gb')
  end

  def create_files
    File.open(@seq_path,'w'){|f| f << @sequences}
  end

  def arguments
    "#{@seq_path} -t=c"
  end

  def unlink
    FileUtils.remove_entry(@dir)
  end

end
end
