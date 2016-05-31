class CreateRunProfileReports < ActiveRecord::Migration
  def change
    create_table :run_profile_reports do |t|
      t.integer :group_id, null: false
      t.integer :run_profile_id, null: false

      t.timestamps null: false
    end
  end
end
