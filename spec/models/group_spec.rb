require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to validate_presence_of(:fasta_file)}
  it { is_expected.to respond_to(:fasta_file)}

  context "--> with 'simple' fasta file uploaded" do
    let (:group) { Fabricate(:group_with_simple_fasta) }

    describe "#create" do
      it "is expected to create two organisms after it is created", focus: true do
        expect{group}.to change{Identifier.count}.from(0).to(2)
      end
      it "is expected to create two genes after it is created" do
        expect{group}.to change{Sequence.count}.from(0).to(2)
      end
      it "is expected to create just one organism with name 'seq1'" do
        group
        expect(Identifier.where(name: 'seq1').count).to eq(1)
      end
      it "is expected to create just one gene with sequence 'atgc'" do
        group
        expect(Sequence.where(sequence: 'atgc').count).to eq(1)
      end
    end

    describe "#to_bio_alignment_object" do
      it "is expected to return a Bio::Alignment::OriginalAlignment object" do
        expect(group.to_bio_alignment_object.class).to eq(Bio::Alignment::OriginalAlignment)
      end
      it "is expected to return sequences with codenames" do
        returned = group.to_bio_alignment_object.keys.to_set
        all_codenames = Identifier.all.map(&:codename).to_set
        expect(returned).to eq(all_codenames)
      end
    end

  end

  context "--> with 'complicated' fasta file uploaded" do
    describe "#create" do
      let (:comp_group) {create(:group_with_complicated_fasta)}
      it "is expected to create seven organisms after it is created" do
        expect{comp_group}.to change{Identifier.count}.from(0).to(7)
      end
      it "is expected to create seven genes after it is created" do
        expect{comp_group}.to change{Sequence.count}.from(0).to(7)
      end
      it "is expected to create just one organism with name 'Burkholderia cenocepacia J231'" do
        comp_group
        expect(Identifier.where(name: 'Burkholderia cenocepacia J2315').count).to eq(1)
      end
    end
  end
end
