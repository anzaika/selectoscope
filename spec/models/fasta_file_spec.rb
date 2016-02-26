require 'rails_helper'

RSpec.describe FastaFile, type: :model do
  let(:ff) { Fabricate(:simple_fasta_file)}
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:to_bioruby_alignment_object) }


  describe "#to_array_of_two_element_arrays_with_desc_and_seq" do
    it "shoud return what it says =)" do
      run_result = ff.to_array_of_two_element_arrays_with_desc_and_seq
      expect(run_result).to eq( [['seq1','atgc'],['seq2','atgt']] )
    end
  end

end
