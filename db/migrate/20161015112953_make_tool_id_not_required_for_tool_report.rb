class MakeToolIdNotRequiredForToolReport < ActiveRecord::Migration
  def change
    change_column_null :tool_reports, :tool_id, true
  end
end
