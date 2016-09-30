require "rails_helper"

RSpec.describe AlignmentToolExecutor do
  describe "execute" do
    it "runs" do
      group = Fabricate(:group)
      tool = Fabricate(:tool, job: 'alignment', class_name: "Guidance")
      profile = Fabricate(:profile, tool_for_alignment_id: tool.id)
      executor = ProfileExecutor.new({group_id: group.id, profile_id: profile.id})
      AlignmentToolExecutor.new({profile_executor: executor}).execute
    end
  end
end
