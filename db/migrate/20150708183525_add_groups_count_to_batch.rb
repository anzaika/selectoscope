class AddGroupsCountToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :groups_count, :integer
  end
end
