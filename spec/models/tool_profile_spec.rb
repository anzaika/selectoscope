require "rails_helper"

RSpec.describe ToolProfile, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate.build(:tool_profile).save).to be true
    end
  end

  describe "to_s" do
    it "should return a String" do
      expect(Fabricate(:tool_profile).to_s.class).to be String
    end
  end
end
