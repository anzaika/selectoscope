class Batch < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  accepts_nested_attributes_for :groups, allow_destroy: true

  def count_groups
    self.groups.count
  end
end
