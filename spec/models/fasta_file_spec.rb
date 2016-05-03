# == Schema Information
#
# Table name: fasta_files
#
#  id                          :integer          not null, primary key
#  representable_as_fasta_type :string(255)
#  representable_as_fasta_id   :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  file_file_name              :string(255)
#  file_content_type           :string(255)
#  file_file_size              :integer
#  file_updated_at             :datetime
#

require "rails_helper"

RSpec.describe FastaFile, type: :model do
  let(:ff) { Fabricate(:simple_fasta_file) }
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:to_bioruby_alignment_object) }

  describe '#to_array_of_two_element_arrays_with_desc_and_seq' do
    it "shoud return what it says =)" do
      run_result = ff.to_array_of_two_element_arrays_with_desc_and_seq
      expect(run_result).to eq([%w(seq1 ata), %w(seq2 atg), %w(seq3 att), %w(seq4 atc)])
    end
  end
end
