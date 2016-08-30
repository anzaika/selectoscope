require "rails_helper"

RSpec.describe Guidance do
  describe "::run" do
    it "runs" do
      guidance_tool = Fabricate(:tool_for_alignment, class_name: "Guidance")
      profile = Fabricate(:profile, tool_for_alignment_id: guidance_tool.id)
      profile_report = Fabricate(:profile_report, profile: profile)
      
      Guidance.run(profile_report.id)
    end
  end
end
