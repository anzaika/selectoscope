class FixIdentifiers < ActiveRecord::Migration
  def change
    change_column_null :identifiers, :name, false
    add_index :identifiers, :name, unique: true
    add_index :identifiers, :codename, unique: true
  end
end
