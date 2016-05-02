# == Schema Information
#
# Table name: identifiers
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  codename :string(10)
#

require 'rails_helper'

RSpec.describe Identifier, type: :model do

  describe "::create" do
    it "sets the codename after save" do
      i = Identifier.new(name: 'name')
      i.save
      expect(i.codename.class).to eq(String)
    end
    it "replaces whitespaces in names to underscores" do
      i = Identifier.new(name: 'one two')
      i.save
      expect(i.name).to eq("one_two")
    end
  end

  describe "::decode_string" do
    it "replaces all the codenames with names in the passed string" do
      group = Fabricate(:group_with_complicated_fasta)
      encoded = group.identifiers.map(&:codename).join("&")
      decoded = group.identifiers.map(&:name).join("&")
      expect(Identifier::Enigma.new(Group.first.id).decode_string(encoded)).to eq(decoded)
    end
  end

  describe "::encode_string" do
    it "replaces all the names with codenames in the passed string" do
      group = Fabricate(:group_with_complicated_fasta)
      decoded = group.identifiers.map(&:name).join("&")
      encoded = group.identifiers.map(&:codename).join("&")
      expect(Identifier::Enigma.new(Group.first.id).encode_string(decoded)).to eq(encoded)

    end
  end
end
