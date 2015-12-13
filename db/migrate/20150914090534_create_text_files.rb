class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.string :has_text_files_type
      t.integer :has_text_files_id
      t.string :type
      t.attachment :file

      t.timestamps null: false
    end

    add_index :text_files, [:has_text_files_type, :has_text_files_id]
    add_index :text_files, [:has_text_files_type, :type, :has_text_files_id]
  end
end
