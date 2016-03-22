class Group::ForJob < ActiveType::Record[Group]

  def alignment
    original  = alignments.original
    processed = alignments.processed

    if processed.count > 0
      return processed.first
    elsif original.count > 0
      return original.first
    else
      nil
    end
  end

  # For CodemlJob
  # def simple_tree(short:)
  #   tree = self.tree.newick_without_inner_node_names
  #   if short
  #     tr(tree)
  #   else
  #     tree
  #   end
  # end

end
