Fabricator(:group) do
  fasta_file
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

Fabricator(:group_with_good_fast, from: :group) do
  alignments(count: 2)
  tree do
    Fabricate(
      :tree,
      newick: File.open('/opt/app/spec/fixtures/good_fast/tree.nwk').read.chomp
    )
  end
  fast_result { Fabricate(:fast_result_good) }
end
