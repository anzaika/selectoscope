class CreateRunnableRunReportAssociations < ActiveRecord::Migration
  def change
    create_table :runnable_run_report_associations do |t|
      t.string :runnable_type
      t.integer :runnable_id
      t.integer :run_report_id

      t.timestamps null: false
    end
  end
end
