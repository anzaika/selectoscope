class CreateCodemlResult < ActiveRecord::Migration
  def change
    create_table :codeml_results do |t|
      t.float :k
      t.float :w0
      t.float :w1
      t.float :p0
      t.float :p1
      t.text :tree

      t.integer :group_id
    end
  end
end
