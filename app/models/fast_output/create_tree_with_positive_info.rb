module FastOutput
  class CreateTreeWithPositiveInfo
    # @param original_tree [PhylogeneticTree] An original tree from a group that was
    # 															 passed as input to fast.
    # @param fast_tree [PhylogeneticTree] A tree from fast
    # @param branches [Array<FastOutput::Branch>]
    # @return [PhylogeneticTree]
    def initialize(original_tree, fast_tree, branches)
      @origin_tree = original_tree
      @fast_tree = fast_tree
      @branches = branches
    end

    def run
      rep = positive_report_for_branches
      @original_tree.newick_without_inner_node_names
                    .gsub(/\):\d+.\d+/) {|s| ")" + rep.shift + s.split(")").last }
    end

    private

    def positive_report
      @branches.map(&:positive?)
    end

    def positive_report_for_branches
      @fast_tree.branch_nums.map {|i| positive_report[i] ? "-" : "" }
    end
  end
end
