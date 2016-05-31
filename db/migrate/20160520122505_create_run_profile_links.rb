class CreateRunProfileLinks < ActiveRecord::Migration
  def change
    create_table :run_profile_links do |t|
      t.integer :group_id, null: false
      t.integer :run_profile_id, null: false

      t.timestamps null: false
    end

    add_index :run_profile_links, %i(run_profile_id group_id)
    add_index :run_profile_links, %i(group_id run_profile_id)
  end
end
