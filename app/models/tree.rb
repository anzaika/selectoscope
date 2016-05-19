class Tree < ActiveRecord::Base
  belongs_to :treeable, polymorphic: true

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

  def to_file(&block)
    Tempfile.create("group#{group.id}_tree.nwk") do
      send_data(newick, type: "application/text", filename: 'tree.nwk')
    end
  end
end

# == Schema Information
#
# Table name: trees
#
#  id            :integer          not null, primary key
#  newick        :binary(65535)
#  treeable_id   :integer          not null
#  treeable_type :string(20)       not null
#
# Indexes
#
#  index_trees_on_treeable_id_and_treeable_type  (treeable_id,treeable_type)
#
