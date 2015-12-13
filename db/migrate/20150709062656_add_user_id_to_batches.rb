class AddUserIdToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :user_id, :integer
  end
end
