Fabricator(:group) do
end

Fabricator(:group_with_simple_fasta, from: :group) do
  fasta_file { Fabricate(:simple_fasta_file) }
end

Fabricator(:group_with_complicated_fasta, from: :group) do
  fasta_file { Fabricate(:complicated_fasta_file) }
end

Fabricator(:group_with_alignment, from: :group) do
  fasta_file { Fabricate(:complicated_fasta_file) }
  alignments { [Fabricate(:original_alignment_for_complicated_fasta)] }
end

Fabricator(:group_with_tree_and_alignment, from: :group) do
  fasta_file { Fabricate(:complicated_fasta_file) }
  alignments { [Fabricate(:original_alignment_for_complicated_fasta)] }
  tree { Fabricate(:tree_for_aligned_complicated_fasta) }
end
