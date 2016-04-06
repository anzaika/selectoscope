require 'rails_helper'

RSpec.describe Wrap::Mafft::Report do
  describe "#save" do

    let(:g) { Fabricate(:group_with_simple_fasta) }
    let(:m)  { Wrap::Mafft::Run.new(g) }
    let(:mrep)  { m.execute; Wrap::Mafft::Report.new(m) }

    it "runs" do
      mrep
      mrep.save
    end

  end
end
