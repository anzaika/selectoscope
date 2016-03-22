module Wrap
class Phyml::Report < Wrap::Report

  def save_output
    newick = File.open(@run.path_to_output).read.chomp.squish
    newick_decoded = Identifier::Enigma.new(@g.id).decode_string(newick)

    @g.tree.destroy if @g.tree
    Tree.create(newick: newick_decoded, treeable: @g)
  end

end
end
