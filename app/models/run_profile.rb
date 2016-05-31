class RunProfile < ActiveRecord::Base
  has_many :run_profile_links, dependent: :destroy
  belongs_to :user
end

# == Schema Information 
#
# Table name: run_profiles
#
#  id                  :integer          not null, primary key
#  run_profile_link_id :integer
#  name                :string(255)      not null
#  description         :text(65535)
#  user_id             :integer          not null
#  alignment           :string(50)       not null
#  tree                :string(50)       not null
#  selection           :string(50)       not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_run_profiles_on_user_id_and_name                 (user_id,name)
#  index_run_profiles_on_user_id_and_run_profile_link_id  (user_id,run_profile_link_id)
#
