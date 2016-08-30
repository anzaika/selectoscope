class ProfileGroupLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :profile
end

# == Schema Information
#
# Table name: profile_group_links
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  profile_id :integer          not null
#
# Indexes
#
#  index_profile_group_links_on_group_id                 (group_id)
#  index_profile_group_links_on_profile_id_and_group_id  (profile_id,group_id) UNIQUE
#
