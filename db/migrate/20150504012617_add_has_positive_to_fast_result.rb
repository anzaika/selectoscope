class AddHasPositiveToFastResult < ActiveRecord::Migration
  def change
    add_column :fast_results, :has_positive, :boolean
  end
end
