class Tool < ActiveRecord::Base
  JOBS = %w(alignment filtering tree selection).freeze

  has_many :profile_tool_links, dependent: :destroy
  has_many :tool_reports, dependent: :destroy

  has_many :tool_profiles, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :class_name, uniqueness: true, presence: true

  def wrapper
    class_name.constantize
  end

  def execute(args)
    wrapper.new.execute(args)
  end
end

# == Schema Information
#
# Table name: tools
#
#  id          :integer          not null, primary key
#  name        :string(150)      not null
#  description :text(65535)
#  class_name  :string(80)       not null
#  job         :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tools_on_job  (job)
#
