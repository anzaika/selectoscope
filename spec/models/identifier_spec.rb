require 'rails_helper'

RSpec.describe Identifier, type: :model do
  describe "::create" do
    it "sets the codename after save" do
      i = Identifier.new(name: 'name')
      i.save
      expect(i.codename.class).to eq(String)
    end
  end

  describe "::decode_string" do
    it "replaces all the codenames with names in the passed string" do
      group = Fabricate(:group_with_complicated_fasta)
      encoded = group.identifiers.map(&:codename).join("&")
      decoded = group.identifiers.map(&:name).join("&")
      expect(Identifier.decode_string(Group.first.id, encoded)).to eq(decoded)
    end
  end

  describe "::encode_string" do
    it "replaces all the names with codenames in the passed string" do
      group = Fabricate(:group_with_complicated_fasta)
      decoded = group.identifiers.map(&:name).join("&")
      encoded = group.identifiers.map(&:codename).join("&")
      expect(Identifier.encode_string(Group.first.id, decoded)).to eq(encoded)
    end
  end
end
