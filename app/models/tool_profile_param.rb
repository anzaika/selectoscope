class ToolProfileParam < ActiveRecord::Base
  belongs_to :tool
end

# == Schema Information
#
# Table name: tool_profile_params
#
#  id              :integer          not null, primary key
#  key             :string(255)      not null
#  value           :string(255)      not null
#  tool_profile_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tool_profile_params_on_tool_profile_id  (tool_profile_id)
#
