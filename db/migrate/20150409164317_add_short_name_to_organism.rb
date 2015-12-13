class AddShortNameToOrganism < ActiveRecord::Migration
  def change
    add_column :organisms, :short_name, :string
  end
end
