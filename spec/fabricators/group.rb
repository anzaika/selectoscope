Fabricator(:group) do
  fasta_file
end

Fabricator(:group_with_simple_fasta, from: :group) do
  fasta_file { Fabricate(:simple_fasta_file) }
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
