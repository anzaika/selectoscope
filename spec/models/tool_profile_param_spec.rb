require "rails_helper"

RSpec.describe ToolProfileParam, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:tool_profile_param).save).to be true
    end
  end

  describe "to_s" do
    it "should return a String" do
    end
  end
end
