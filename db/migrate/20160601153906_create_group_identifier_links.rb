class CreateGroupIdentifierLinks < ActiveRecord::Migration
  def change
    create_table :group_identifier_links do |t|
      t.integer :group_id, null: false
      t.integer :identifier_id, null: false
    end

    add_index :group_identifier_links, %i(group_id identifier_id), unique: true
    add_index :group_identifier_links, :identifier_id
    drop_table :groups_identifiers
  end
end
