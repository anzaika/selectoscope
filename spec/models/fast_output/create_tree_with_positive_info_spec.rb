require "rails_helper"

RSpec.describe FastOutput::CreateTreeWithPositive do
  describe "::new" do
    it "works" do
      # codeml_tree = PhylogeneticTree.new(
      #   "(s1: 1.1, s2: 1.1, (s2: 1.1, ((s3: 1.1, (s4: 1.1, s5: 1.1): 1.1): " \
      #   "1.1, ((s6: 1.1, s7: 1.1): 1.1, (s8: 1.1, (s9: 1.1, s10: 1.1): 1.1): 1.1): 1.1): 1.1): 1.1);"
      # )
      fast_tree = PhylogeneticTree.new(
        "(s1,s2,(s2,((s3,(s4,s5)*3)*2,((s6,s7)*5,(s8,(s9,s10)*7)*6)*4)*1)*0);"
      )


      branches = []
      8.times do |i|
        branch = instance_double('FastOutput::Branch')
        allow(branch).to receive(:positive?).and_return(i % 2 == 0)
        branches << branch
      end

      tree = create_tree(fast_tree, branches)
      out = tree.run.newick
      expected = "(s1,s2,(s2,((s3,(s4,s5))-,((s6,s7),(s8,(s9,s10))-)-))-);"
      expect(out).to eq(expected)
    end
  end

  def create_tree(*params)
    FastOutput::CreateTreeWithPositive.new(*params)
  end
end
