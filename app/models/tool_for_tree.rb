class ToolForTree < Tool
  def execute(profile_report_id)
    class_name.constantize.run(profile_report_id)
  end
end

# == Schema Information
#
# Table name: tools
#
#  id          :integer          not null, primary key
#  name        :string(150)      not null
#  description :text(65535)
#  class_name  :string(80)       not null
#  type        :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tools_on_type  (type)
#
