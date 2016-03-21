class Tree < ActiveRecord::Base
  belongs_to :group

  # @param identifiers [Array]
  # @return [String] trimmed tree in newick format
  def trim_for(identifiers)
    file = Tempfile.new("tree.nwk")
    File.open(file.path, "w") {|f| f << newick }

    `nw_prune -v #{file.path} #{identifiers.join(" ")}`.chomp
  ensure
    file.unlink
  end

  def newick_without_inner_node_names
    newick.gsub(/\d+\.\d+\:\d+.\d+/) {|s| ":" + s.split(":").last }
  end

  # Should only be applied for trees with
  def fast_inn_node_names
    newick.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end
end
