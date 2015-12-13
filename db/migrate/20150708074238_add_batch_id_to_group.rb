class AddBatchIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :batch_id, :integer
  end
end
