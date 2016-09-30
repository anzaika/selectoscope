require "rails_helper"

RSpec.describe ProfileExecutor do
  let(:group) {Fabricate(:group)}
  let(:profile) {Fabricate(:profile)}
  let(:executor) {ProfileExecutor.new({group_id: group.id, profile_id: profile.id})}
  describe "::create" do
    it "should be valid with valid params" do
      expect(executor.class).to be ProfileExecutor
    end
  end

  describe "run" do
    context "all tools are present" do
      it "should run" do
        allow_any_instance_of(AlignmentToolExecutor).to receive(:execute).and_return(Fabricate(:alignment))
        expect(executor.run).to be true
      end
    end
    context "profile with no alignment tool" do
      it "should copy the group alignment to profile_report" do
        profile_no_ali = Fabricate(:profile, tool_for_alignment_id: nil)
        execu = ProfileExecutor.new({group_id: group.id, profile_id: profile_no_ali.id})
        execu.run
        expect(execu.report.alignment.class).to be(Alignment)
      end
    end
  end
end
