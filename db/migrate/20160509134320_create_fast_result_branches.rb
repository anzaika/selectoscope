class CreateFastResultBranches < ActiveRecord::Migration
  def change
    create_table :fast_result_branches do |t|
      t.integer :fast_result_id, null:false
      t.integer :number, null: false
      t.decimal :l0, precision: 16, scale: 11
      t.decimal :l1, precision: 16, scale: 11
      t.boolean :positive
    end
    add_index :fast_result_branches, [:fast_result_id, :positive]
  end
end
