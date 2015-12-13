FactoryGirl.define do
  factory :group do
    factory :group_with_simple_fasta do
      association :fasta_file, factory: :simple_fasta_file
    end
    factory :group_with_complicated_fasta do
      association :fasta_file, factory: :complicated_fasta_file
    end
  end
end
