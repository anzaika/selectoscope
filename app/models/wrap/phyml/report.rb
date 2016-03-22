module Wrap
class Phyml::Report < Wrap::Report

  def save_output
    newick = File.open(@run.path_to_output).read
    newick_decoded = Identifier.decode_string(@g.id, newick)
    tree = Tree.create(newick: newick_decoded)

    @g.tree.destroy if @g.tree
    @g.tree = tree
  end

end
end
