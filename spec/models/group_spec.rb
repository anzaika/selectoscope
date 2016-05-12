# == Schema Information
#
# Table name: groups
#
#  id                  :integer          not null, primary key
#  avg_sequence_length :integer
#  batch_id            :integer
#  user_id             :integer
#
# Indexes
#
#  index_groups_on_batch_id  (batch_id)
#  index_groups_on_user_id   (user_id)
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to validate_presence_of(:fasta_file)}
  it { is_expected.to respond_to(:fasta_file)}

  context "--> with 'simple' fasta file uploaded" do
    let (:group) { Fabricate(:group_with_simple_fasta) }

    describe "#create" do
      it "is expected to create two idetifiers", focus: true do
        expect{group}.to change{Identifier.count}.from(0).to(4)
      end
      it "...and link them to the group" do
        group
        expect(group.identifiers.count).to eq(4)
      end
    end
  end

  context "--> when created with a fasta file that has spaces in identifiers" do
    describe "#create" do
      it "rewrites the fasta_file replacing spaces in identifiers with underlines" do
        ff = Fabricate(:fasta_file_with_spaces)
        ids_before =
          ff.to_bioruby_alignment_object
            .keys
            .map { |id| id.split(" ").join("_") }

        g = Group.create(fasta_file: ff)
        ids_after = g.fasta_file.to_bioruby_alignment_object.keys

        expect(ids_before).to eq(ids_after)
      end
    end
  end

  context "--> with 'complicated' fasta file uploaded" do
    let (:comp_group) {Fabricate(:group_with_complicated_fasta)}
    describe "#create" do
      it "is expected to create seven identifiers" do
        expect{comp_group}.to change{Identifier.count}.from(0).to(7)
      end
      it "...and link them to the group" do
        comp_group
        expect(comp_group.identifiers.count).to eq(7)
      end
    end
  end
end
