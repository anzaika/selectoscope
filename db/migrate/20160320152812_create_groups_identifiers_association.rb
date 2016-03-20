class CreateGroupsIdentifiersAssociation < ActiveRecord::Migration
  def change
    create_table :groups_identifiers do |t|
      t.integer :group_id
      t.integer :identifier_id
    end
  end
end
