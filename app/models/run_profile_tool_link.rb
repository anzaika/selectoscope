class RunProfileToolLink < ActiveRecord::Base
  belongs_to :profile
  belongs_to :tool
end

# == Schema Information
#
# Table name: profile_tool_links
#
#  id             :integer          not null, primary key
#  profile_id :integer          not null
#  tool_id        :integer          not null
#
# Indexes
#
#  index_profile_tool_links_on_profile_id              (profile_id)
#  index_profile_tool_links_on_tool_id_and_profile_id  (tool_id,profile_id) UNIQUE
#
