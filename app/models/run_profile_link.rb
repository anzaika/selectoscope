class RunProfileLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :run_profile
end

# == Schema Information
#
# Table name: run_profile_links
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  run_profile_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_run_profile_links_on_group_id_and_run_profile_id  (group_id,run_profile_id)
#  index_run_profile_links_on_run_profile_id_and_group_id  (run_profile_id,group_id)
#
