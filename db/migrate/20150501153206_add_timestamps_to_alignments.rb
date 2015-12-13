class AddTimestampsToAlignments < ActiveRecord::Migration
  def change
    add_column(:alignments, :created_at, :datetime)
    add_column(:alignments, :updated_at, :datetime)
  end
end
