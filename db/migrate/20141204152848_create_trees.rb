class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.string :name
      t.text   :newick

      t.timestamps
    end
  end
end
