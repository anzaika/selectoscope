require "rails_helper"

RSpec.describe FastOutput::CreateTreeWithPositiveInfo do
  describe "::new" do
    it "works" do
      original_tree = PhylogeneticTree.new("(A,B,(C,D));")
      fast_tree = PhylogeneticTree.new(
        "(seq4:7.775817*0,(seq1:0.000000*2,seq3:0.521281*3):6.326581*1,seq2:0.000000*4);"
      )
      create_tree()
    end
  end

  def create_tree(*params)
    FastOutput::CreateTreeWithPositiveInfo.new(params)
  end
end
