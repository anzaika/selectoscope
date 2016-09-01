class FixTreeTreeableNotNull < ActiveRecord::Migration
  def change
    change_column_null :trees, :treeable_id, true
    change_column_null :trees, :treeable_type, true
  end
end
