require 'rails_helper'

RSpec.describe Wrap::Guidance::Report do
  describe "#save" do

    let(:g) { Fabricate(:group_with_simple_fasta) }
    let(:w)  { Wrap::Guidance::Run.new(g.id) }
    let(:wrep)  { w.execute; Wrap::Guidance::Report.new(w) }

    it "runs" do
      wrep
      wrep.save
    end


  end
end
