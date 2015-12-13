class AddHasParalogsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :has_paralogs, :boolean
  end
end
