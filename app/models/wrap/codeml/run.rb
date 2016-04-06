module Wrap
class Codeml::Run < Wrap::Run

  PROGRAM = "PAML-codeml"
  EXEC = "cdmw.py"
  ALIGNMENT = "aligned.fasta"
  TREE = "tree.nwk"
  OUTPUT = "output.out"

  def args
    @args ||= "--method 1 --preset M1 #{@v.path_to(ALIGNMENT)} #{@v.path_to(TREE)} #{@v.path_to(OUTPUT)}"
  end

  def version
    ''
  end

  def setup_files
    copy_encoded_alignment
    copy_encoded_tree
  end

  def copy_encoded_alignment
    fasta = @g.alignment.to_molphy_string
    encoded = Identifier::Enigma.new(@g.id).encode_string(fasta)
    @v.write_to_file(encoded, ALIGNMENT)
  end

  def copy_encoded_tree
    tree = @g.tree.newick_without_inner_node_names
    encoded = Identifier::Enigma.new(@g.id).encode_string(tree)
    @v.write_to_file(encoded, TREE)
  end

end
end
