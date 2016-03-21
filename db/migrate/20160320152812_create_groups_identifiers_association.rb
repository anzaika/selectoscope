class CreateGroupsIdentifiersAssociation < ActiveRecord::Migration
  def change
    create_table :groups_identifiers, id: false do |t|
      t.integer :group_id
      t.integer :identifier_id
    end

    add_index :groups_identifiers, [:group_id, :identifier_id], unique: true
    add_index :groups_identifiers, :identifier_id
  end
end
