class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
