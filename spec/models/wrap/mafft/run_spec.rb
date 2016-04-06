require 'rails_helper'

RSpec.describe Wrap::Mafft::Run do
  describe "#execute" do

    let(:g)  { Fabricate(:group_with_simple_fasta) }
    let(:m)  { Wrap::Mafft::Run.new(g) }

    context "for simple fasta file" do

      it "runs" do
        m.execute
      end

      it "creates an output file" do
        m.execute
        expect(FileTest.exist?(m.path_to_output)).to be(true)
      end

    end
  end
end
