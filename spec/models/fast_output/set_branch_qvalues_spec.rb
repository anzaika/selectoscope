require "rails_helper"

RSpec.describe FastOutput::SetBranchQvalues do
  context "with corrent input" do
    describe "::create" do
      it "should work" do
        FastOutput::SetBranchQvalues.create([])
      end
    end
  end
end
