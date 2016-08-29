require "rails_helper"

RSpec.describe RunProfile, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:profile).save).to be true
    end
  end
end
