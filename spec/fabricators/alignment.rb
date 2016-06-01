Fabricator(:alignment) do
  fasta_file
end

Fabricator(:original_alignment_for_complicated_fasta, from: :alignment) do
  meta 'original'
  fasta_file { Fabricate(:aligned_complicated_fasta_file) }
end
