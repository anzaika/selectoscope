class CreateFastResults < ActiveRecord::Migration
  def change
    create_table :fast_results do |t|
      t.text :report
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
