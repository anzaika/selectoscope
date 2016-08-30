require "rails_helper"

RSpec.describe FastOutput::Output do
  context "given a run_report with successfull launch" do
    let(:o) { out(Fabricate(:run_report_fast).id) }

    describe "::new" do
      it "should work" do
        o
      end
    end

    describe "branches" do
      it "should return an array" do
        expect(o.branches.class).to eq(Array)
      end
    end

    describe "#sites" do
      it "should return an array" do
        expect(o.sites.class).to eq(Array)
      end
    end

    describe "#tree" do
      it "should return a Tree" do
        expect(o.tree.class).to eq(Tree)
      end
    end

    describe "#tree_with_positive" do
      it "should return a Tree" do
        expect(o.tree_with_positive.class).to eq(Tree)
      end
    end
  end

  def out(run_report_id)
    FastOutput::Output.new(run_report_id)
  end
end
