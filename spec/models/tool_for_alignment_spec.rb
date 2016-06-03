require "rails_helper"

RSpec.describe ToolForAlignment, type: :model do
  describe "execute" do
    let(:tool) { Fabricate(:tool_for_alignment, class_name: "Guidance") }
    it "works" do
      run_profile_run_report = Fabricate(:run_profile_run_report)
      tool.execute(run_profile_run_report.id)
    end
  end
end
