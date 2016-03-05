Fabricator(:fasta_file) do
end

Fabricator(:simple_fasta_file, from: :fasta_file) do
  file do
    File.open(File.join(Rails.root, 'spec', 'fixtures', 'fasta_files', 'simple.fasta'))
  end
end

Fabricator(:complicated_fasta_file, from: :fasta_file) do
  file do
    File.open(File.join(Rails.root, 'spec', 'fixtures', 'fasta_files', 'complicated.fasta'))
  end
end
