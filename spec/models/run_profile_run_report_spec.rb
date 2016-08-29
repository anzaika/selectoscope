require "rails_helper"

RSpec.describe ProfileReport, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      Fabricate(:profile_report)
    end
  end
end
