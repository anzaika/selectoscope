Fabricator(:fasta_file) do
end

Fabricator(:fasta_file_with_spaces, from: :fasta_file) do
  file do
    File.open(File.join(Rails.root, 'spec', 'fixtures', 'fasta_files', 'with_spaces.fasta'))
  end
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

Fabricator(:aligned_complicated_fasta_file, from: :fasta_file) do
  file do
    File.open(File.join(Rails.root, 'spec', 'fixtures', 'fasta_files', 'complicated_aligned.fasta'))
  end
end
