require "rails_helper"

RSpec.describe ToolForAlignment, type: :model do
  describe "execute" do
    let(:tool) { Fabricate(:tool_for_alignment, class_name: "Guidance") }
    it "works" do
      profile_report = Fabricate(:profile_report)
      tool.execute(profile_report.id)
    end
  end
end
