class ProfileReport < ActiveRecord::Base
  belongs_to :group
  belongs_to :profile

  has_many :tool_reports, dependent: :nullify

  has_one :alignment, as: :alignable, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy
  has_one :codeml_result, dependent: :destroy
  has_one :fast_result, dependent: :destroy
end

# == Schema Information
#
# Table name: profile_reports
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  profile_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
