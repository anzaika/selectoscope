class CreateRunProfileGroupLinks < ActiveRecord::Migration
  def change
    create_table :run_profile_group_links do |t|
      t.integer :group_id, null: false
      t.integer :run_profile_id, null: false
    end

    add_index :run_profile_group_links, %i(run_profile_id group_id), unique: true
    add_index :run_profile_group_links, :group_id
  end
end
