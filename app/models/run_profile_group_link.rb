class RunProfileGroupLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :run_profile
end

# == Schema Information
#
# Table name: run_profile_group_links
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  run_profile_id :integer          not null
#
# Indexes
#
#  index_run_profile_group_links_on_group_id                     (group_id)
#  index_run_profile_group_links_on_run_profile_id_and_group_id  (run_profile_id,group_id) UNIQUE
#
