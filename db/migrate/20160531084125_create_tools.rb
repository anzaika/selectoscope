class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name, null: false, limit: 150
      t.text :description
      t.string :class_name, null: false, limit: 80
      t.string :type, null: false, limit: 50

      t.timestamps null: false
    end

    add_index :tools, :type
  end
end
