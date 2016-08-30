require "rails_helper"

RSpec.describe Tool, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:tool).save).to be true
    end
  end
end
