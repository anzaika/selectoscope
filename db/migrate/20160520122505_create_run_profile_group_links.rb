class CreateProfileGroupLinks < ActiveRecord::Migration
  def change
    create_table :profile_group_links do |t|
      t.integer :group_id, null: false
      t.integer :profile_id, null: false
    end

    add_index :profile_group_links, %i(profile_id group_id), unique: true
    add_index :profile_group_links, :group_id
  end
end
