require 'rails_helper'

RSpec.describe Wrap::AlignmentJob do
  describe "#perform" do
    let(:g) { Fabricate(:group_with_simple_fasta) }

    it "runs" do
      Wrap::AlignmentJob.new.perform(g.id)
    end

    it "assigns an alignment to group" do
      expect{Wrap::AlignmentJob.new.perform(g.id)}.to change{g.alignments.count}.by(1)
    end

  end
end
