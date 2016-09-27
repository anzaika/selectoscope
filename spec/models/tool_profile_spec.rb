require "rails_helper"

RSpec.describe ToolProfile, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:tool_profile).save).to be true
    end
  end
end
