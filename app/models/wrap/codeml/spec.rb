module Wrap::Codeml
class Spec
  OUTPUT_FILENAME = 'codeml_output'

  attr_reader :result_path

  # @param molphy [String] sequences in molphy format
  # @param tree [String] tree in newick format
  def initialize(molphy:, tree:)
    @sequences = molphy
    @tree = tree
    @dir = Dir.mktmpdir

    @seq_path    = File.join(@dir, 'sequences.phy')
    @tree_path   = File.join(@dir, 'tree.nwk')
    @result_path = File.join(@dir, OUTPUT_FILENAME)
  end

  def create_files
    File.open(@seq_path,'w'){|f| f << @sequences}
    File.open(@tree_path,'w'){|f| f << @tree}
  end

  def arguments
    "--preset M1 #{@seq_path} #{@tree_path} #{@result_path}"
  end

  def unlink
    FileUtils.remove_entry(@dir)
  end

end
end
