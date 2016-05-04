class FastResult::Output
  def initialize(fast_result_id)
    @fr = FastResult.find(fast_result_id)
    @g = @fr.group
    @output = @fr.output
  end

  def process
    # analyze_branches
  end

  def parse_tree
  end

  def set_has_positive
    return nil unless positive_report
    update_attribute(:has_positive, positive_report.include?(true))
  end

  def positive_report
    branches.map(&:positive?)
  end

  def branches
    @branches ||=
      @text.split(/Branch\:\s+\d+/)
           .tap(&:shift)
           .map { |text| OutputBranch.new(text) }
  end

  def tree_with_positive_info
    return nil unless group.tree && rep
    rep = positive_report_for_branches
    group.tree
      .newick_without_inner_node_names
      .gsub(/\):\d+.\d+/) {|s| ")" + rep.shift + s.split(")").last }
  end

  def positive_report_for_branches
    branch_nums && branch_nums.map {|i| positive_report[i] ? "-" : "" }
  end

  def branch_nums
    tree_row = stdout.split("\n")
               .index("Annotated Newick tree (*N mark the internal branch N)")
    return nil unless tree_row
    tree = stdout.split("\n")[tree_row + 1]
    tree.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end
end
