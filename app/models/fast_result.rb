class FastResult < ActiveRecord::Base
  belongs_to :group
  has_one :text_file, as: :textifilable, dependent: :destroy
  after_create :set_has_positive

  THRESHOLD = 3.841459

  def set_has_positive
    return nil unless positive_report
    update_attribute(:has_positive, positive_report.compact.size > 0)
  end

  def positive_report
    return nil unless output
    report_to_branches(output)
      .map {|br| branch_positive?(br) }
  end

  def tree_with_positive_info
    return nil unless group.tree && rep
    rep = positive_report_for_branches
    group.tree
      .newick_without_inner_node_names
      .gsub(/\):\d+.\d+/) {|s| ")" + rep.shift + s.split(")").last }
  end

  def positive_report_for_branches
    rep = positive_report
    branch_nums && branch_nums.map {|i| rep[i] ? "-" : "" }
  end

  def branch_nums
    tree_row = stdout.split("\n")
               .index("Annotated Newick tree (*N mark the internal branch N)")
    return nil unless tree_row
    tree = stdout.split("\n")[tree_row + 1]
    tree.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end

  private

  def report_to_branches(string)
    string.split(/Branch\:\s+\d+/)
      .tap(&:shift)
  end

  def branch_positive?(string)
    return nil unless l_one_from_branch(string) && l_zero_from_branch(string)
    positive?(l_one_from_branch(string), l_zero_from_branch(string))
  end

  def l_one_from_branch(string)
    string.each_line
      .to_a
      .map {|l| l_one_from_string(l) }
      .compact
      .first
  end

  def l_zero_from_branch(string)
    string.each_line
      .to_a
      .map {|l| l_zero_from_string(l) }
      .compact
      .first
  end

  def l_zero_from_string(string)
    return nil unless string =~ /LnL0\:\s+(\s|-)\d+.\d+/
    string.split(":").last.to_f
  end

  def l_one_from_string(string)
    return nil unless string =~ /LnL1\:\s+(\s|-)\d+.\d+/
    string.split(":").last.to_f
  end

  def positive?(l_one, l_zero)
    return nil unless l_one && l_zero
    (2 * (l_one - l_zero) - THRESHOLD) > 0
  end
end
