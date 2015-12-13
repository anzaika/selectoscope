class GroupDecorator < Draper::Decorator
  delegate_all

  def orig_align
    object.alignments.original.first
  end

  def gblocks_align
    object.alignments.gblocks.first
  end

  # def tree(short: false)
  #   if object.fast_result
  #     # tree = object.fast_result.tree_with_positive_info
  #     # tr(tree) if short
  #     object.fast_result.tree_with_positive_info
  #   elsif object.tree
  #     object.tree.newick
  #   end
  # end

  def simple_tree(short:)
    tree = object.tree.newick_without_inner_node_names
    if short
      tr(tree)
    else
      tree
    end
  end

  def tree_for_group_index_view
    tree.with_translated_name
  end

  def tree_for_group_show_view
    if object.fast_result
      Identifier.tr(object.fast_result.tree_with_positive_info)
    else
      tree.with_translated_name
    end
  end

  def tree_for_fast
  end
end
