# == Schema Information
#
# Table name: fast_results
#
#  id           :integer          not null, primary key
#  group_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_positive :boolean
#

require 'rails_helper'

RSpec.describe FastResult, type: :model do
end
