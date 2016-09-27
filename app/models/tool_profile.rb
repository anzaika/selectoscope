class ToolProfile < ActiveRecord::Base
  belongs_to :tool
  has_many :tool_profile_params, dependent: :destroy

  def hi
  end

end

# == Schema Information
#
# Table name: tool_profiles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text(65535)
#  tool_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tool_profiles_on_tool_id  (tool_id)
#
