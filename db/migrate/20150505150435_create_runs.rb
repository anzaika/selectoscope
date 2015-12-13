class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :program
      t.string :version
      t.string :params
      t.text :stdout
      t.text :stderr
      t.text :result
      t.date :start
      t.date :finish
      t.integer :runtime
      t.text :directory_snapshot
      t.integer :jobid
      t.integer :runnable_id

      t.timestamps null: false
    end
  end
end
