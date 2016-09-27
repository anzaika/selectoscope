require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) {Fabricate(:profile)}
  
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:profile).save).to be true
    end
  end

  describe "tool_for" do
    it "should return a Tool object" do
      expect(profile.tool_for(:alignment).class).to be Tool
    end
  end
end
