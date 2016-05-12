# == Schema Information
#
# Table name: batches
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  groups_count :integer
#  user_id      :integer
#
# Indexes
#
#  index_batches_on_user_id  (user_id)
#

class Batch < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  accepts_nested_attributes_for :groups, allow_destroy: true

  def count_groups
    self.groups.count
  end

  def count_groups_with_positive
    groups.with_positive.count
  end

  def percent_of_groups_with_positive
    return nil if groups.count == 0
    ((count_groups_with_positive / groups.count.to_f) * 100).to_i
  end
end
