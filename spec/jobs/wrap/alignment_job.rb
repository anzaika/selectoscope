require 'rails_helper'

RSpec.describe AlignmentJob do
  describe "#perform" do
    let(:g) { Fabricate(:group_with_simple_fasta) }

    it "runs" do
      AlignmentJob.new.perform(g.id)
    end

    it "assigns an alignment to group" do
      expect{AlignmentJob.new.perform(g.id)}.to change{g.alignments.count}.by(1)
    end

  end
end
