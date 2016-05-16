# == Schema Information
#
# Table name: groups
#
#  id                  :integer          not null, primary key
#  avg_sequence_length :integer
#  batch_id            :integer
#  user_id             :integer
#  preprocessing_done  :boolean          default(FALSE), not null
#
# Indexes
#
#  index_groups_on_batch_id  (batch_id)
#  index_groups_on_user_id   (user_id)
#

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
