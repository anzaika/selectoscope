class ToolProfileParam < ActiveRecord::Base
  KEY_REGEX = /\A-{1,2}[a-zA-Z-_\d]*\z/

  belongs_to :tool
  validates_format_of :key,
    with: KEY_REGEX,
    message: "Keys should be like: -v or --something-something"

  def to_s
    key + " " + value
  end
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
