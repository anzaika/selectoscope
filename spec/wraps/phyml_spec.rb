require "rails_helper"

RSpec.describe Phyml do
  describe "::run" do
    it "runs" do
      tool = Fabricate(:tool_for_tree, class_name: "Phyml")
      profile = Fabricate(:profile, tool_for_tree_id: tool.id)
      profile_report = Fabricate(:profile_report, profile: profile)
      profile_report.alignment = Fabricate(:alignment)
      
      Phyml.run(profile_report.id)
    end
  end
end
