module Wrap::Codeml
class Spec
  OUTPUT_FILENAME = 'codeml_output'
  STD_OUT = 'stdout'

  attr_reader :result_path, :stdout_path

  # @param molphy [String] sequences in molphy format
  # @param tree [String] tree in newick format
  def initialize(molphy:, tree:)
    @sequences = molphy
    @tree = tree
    @dir = Dir.mktmpdir

    @seq_path    = File.join(@dir, 'sequences.phy')
    @tree_path   = File.join(@dir, 'tree.nwk')
    @result_path = File.join(@dir, OUTPUT_FILENAME)
    @stdout_path = File.join(@dir, STD_OUT)
  end

  def create_files
    File.open(@seq_path,'w'){|f| f << @sequences}
    File.open(@tree_path,'w'){|f| f << @tree}
    FileUtils.touch(@stdout_path)
  end

  def arguments
    "--preset M1 #{@seq_path} #{@tree_path} #{@result_path}"
  end

  def unlink
    FileUtils.remove_entry(@dir)
  end

end
end
