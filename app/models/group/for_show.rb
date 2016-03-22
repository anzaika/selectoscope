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
end
