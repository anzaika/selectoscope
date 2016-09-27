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
        allow_any_instance_of(Tool).to receive(:execute).and_return(true)
        expect(executor.run).to be true
      end
    end
    context "profile with no alignment tool" do
    end
  end
end
