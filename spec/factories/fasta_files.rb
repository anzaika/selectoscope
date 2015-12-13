FactoryGirl.define do
  factory :fasta_file do
    factory :simple_fasta_file do
      file { fixture_file_upload 'spec/fixtures/fasta_files/simple.fasta', 'application/octet-stream'}
    end
    factory :complicated_fasta_file do
      file { fixture_file_upload 'spec/fixtures/fasta_files/complicated.fasta', 'application/octet-stream'}
    end
  end
end
