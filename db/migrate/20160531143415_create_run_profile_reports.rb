class CreateRunProfileReports < ActiveRecord::Migration
  def change
    create_table :profile_reports do |t|
      t.integer :group_id, null: false
      t.integer :profile_id, null: false

      t.timestamps null: false
    end
  end
end
