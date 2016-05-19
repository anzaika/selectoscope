require 'rails_helper'

RSpec.describe Mafft::Report do
  describe "#save" do

    let(:g) { Fabricate(:group_with_simple_fasta) }
    let(:m)  { Mafft::Run.new(g) }
    let(:mrep)  { m.execute; Mafft::Report.new(m) }

    it "runs" do
      mrep
      mrep.save
    end

  end
end
