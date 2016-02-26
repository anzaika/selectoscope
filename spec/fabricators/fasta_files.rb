Fabricator(:fasta_file) do
end

Fabricator(:simple_fasta_file, from: :fasta_file) do
  file { fixture_file_upload 'spec/fixtures/fasta_files/simple.fasta', 'application/octet-stream'}
end

Fabricator(:complicated_fasta_file, from: :fasta_file) do
  file { fixture_file_upload 'spec/fixtures/fasta_files/complicated.fasta', 'application/octet-stream'}
end
