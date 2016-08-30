module FastOutput
  class CreateTreeWithPositive
    # @param fast_tree [Tree] A tree from fast run
    # @param branches [Array<FastOutput::Branch>]
    # @return [Tree]
    def initialize(fast_tree, branches)
      @fast_tree = fast_tree
      @branches = branches
    end


    def run
      tree = @fast_tree.newick.gsub(/\*\d+/) do |v|
        branch_num = v.split("*").last.to_i
        @branches[branch_num].positive? ? "-" : ""
      end
      Tree.new(tree)
    end

    # def run
    #   rep = positive_report_for_branches
    #   @original_tree.newick_without_inner_node_names
    #                 .gsub(/\):\d+.\d+/) {|s| ")" + rep.shift + s.split(")").last }
    # end
    #
  end
end
