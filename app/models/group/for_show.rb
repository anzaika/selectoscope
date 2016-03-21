class Group::ForShow < ActiveType::Record[Group]
  def original_alignment
    alignments.original.first
  end

  def processed_alignment
    alignments.processed.first
  end
end
