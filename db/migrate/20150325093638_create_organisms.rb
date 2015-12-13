class CreateOrganisms < ActiveRecord::Migration
  def change
    create_table :organisms do |t|
      t.string :name
      t.integer :genes_count
    end
  end
end
