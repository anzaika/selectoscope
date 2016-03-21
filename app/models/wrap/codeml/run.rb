module Wrap
class Codeml::Run

  attr_reader :args, :path_to_output, :v, :g

  EXEC = "cdmw.py"
  ALIGNMENT = "aligned.fasta"
  TREE = "tree.nwk"
  OUTPUT = "output"

  def initialize(group_id)
    @v = Vault.new
    @g = Group::ForJob.find(group_id)
  end

  def execute
    setup_files
    run
  end

  def path_to_output
    @v.path_to(OUTPUT)
  end

  def args
    @args ||= "--preset M1 #{@v.path_to(ALIGNMENT)} #{@v.path_to(TREE)} #{@v.path_to(OUTPUT)}"
  end

  private

  def setup_files
    copy_encoded_alignment
    copy_encoded_tree
  end

  def copy_encoded_alignment
    fasta = @g.alignment.to_molphy_string
    encoded = Identifier.encode_string(@g.id, fasta)
    @v.write_to_file(encoded, ALIGNMENT)
  end

  def copy_encoded_tree
    tree = @g.tree.newick_without_inner_node_names
    encoded = Identifier.encode_string(@g.id, tree)
    @v.write_to_file(encoded, TREE)
  end

  def run
    @v.run(EXEC, args)
  end

end
end
