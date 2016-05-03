require 'rails_helper'

RSpec.describe Wrap::Guidance::Report do
  describe "#save" do
    let(:g) { Fabricate(:group_with_simple_fasta) }
    let(:w) { Wrap::Guidance::Run.new(g.id) }
    let(:wrep) do
      w.execute
      Wrap::Guidance::Report.new(w)
    end

    it "runs" do
      wrep
      wrep.save
    end
    it "creates an alignment" do
      wrep
      wrep.save
      expect(Alignment.count).to be(1)
    end
  end
end
