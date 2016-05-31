class RunProfileToolLink < ActiveRecord::Base
  belongs_to :run_profile
  belongs_to :tool
end

# == Schema Information
#
# Table name: run_profile_tool_links
#
#  id             :integer          not null, primary key
#  run_profile_id :integer          not null
#  tool_id        :integer          not null
#
# Indexes
#
#  index_run_profile_tool_links_on_run_profile_id              (run_profile_id)
#  index_run_profile_tool_links_on_tool_id_and_run_profile_id  (tool_id,run_profile_id) UNIQUE
#
