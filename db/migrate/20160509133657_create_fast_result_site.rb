class CreateFastResultSite < ActiveRecord::Migration
  def change
    create_table :fast_result_sites do |t|
      t.integer :fast_result_id, null:false
      t.integer :branch, null: false
      t.integer :site, null: false
      t.decimal :probability, null: false, precision: 7, scale: 6
    end

    add_index :fast_result_sites, :fast_result_id
  end
end
