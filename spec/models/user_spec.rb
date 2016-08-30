require "rails_helper"

RSpec.describe User, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      expect(Fabricate(:user).save).to be true
    end
  end
end
