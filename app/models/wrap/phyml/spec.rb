module Wrap::Phyml
class Spec
  attr_reader :result_path

  def initialize(phylip:)
    @sequences = phylip
    @dir = Dir.mktmpdir

    @seq_path    = File.join(@dir, 'sequences.phylip')
    @result_path = File.join(@dir, 'sequences.phylip_phyml_tree')
  end

  def create_files
    File.open(@seq_path,'w'){|f| f << @sequences}
  end

  def arguments
    "-q -i #{@seq_path}"
  end

  def unlink
    FileUtils.remove_entry(@dir)
  end
end
end
