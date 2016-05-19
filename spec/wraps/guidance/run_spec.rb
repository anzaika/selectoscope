require "rails_helper"

RSpec.describe Guidance::Run do
  describe "#execute", speed: "slow" do
    let(:g)  { Fabricate(:group_with_simple_fasta) }
    let(:w)  { Guidance::Run.new(g) }
    context "for simple fasta file" do
      it "runs" do
        w.execute
      end
      it "creates an output directory" do
        w
        w.execute
        expect(Dir.exist?(w.path_to_output)).to be true
      end
    end
  end
end
