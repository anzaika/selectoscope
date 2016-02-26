Fabricator(:group) do
end

Fabricator(:group_with_simple_fasta, from: :group) do
  fasta_file { Fabricate(:simple_fasta_file) }
end

Fabricator(:group_with_complicated_fasta, from: :group) do
  fasta_file { Fabricate(:complicated_fasta_file) }
end
