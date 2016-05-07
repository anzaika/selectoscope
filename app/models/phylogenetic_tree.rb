class PhylogeneticTree
  attr_reader :newick
  def initialize(newick)
    @newick = newick
  end

  def newick_without_inner_node_names
    @newick.gsub(/\d+\.\d+\:\d+.\d+/) {|s| ":" + s.split(":").last }
  end

  def branch_nums
    @newick.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end
end
