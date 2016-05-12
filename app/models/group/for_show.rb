# == Schema Information
#
# Table name: groups
#
#  id                  :integer          not null, primary key
#  avg_sequence_length :integer
#  batch_id            :integer
#  user_id             :integer
#
# Indexes
#
#  index_groups_on_batch_id  (batch_id)
#  index_groups_on_user_id   (user_id)
#

class Group::ForShow < ActiveType::Record[Group]
  def original_alignment
    alignments.original.first
  end

  def processed_alignment
    alignments.processed.first
  end

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

  def alignment_job
    run_reports.alignment.first
  end

  def processed_alignment_job
    run_reports.processed_alignment.first
  end

  def tree_job
    run_reports.tree.first
  end

  def codeml_job
    run_reports.codeml.first
  end

  def fast_job
    run_reports.fast.first
  end
end
