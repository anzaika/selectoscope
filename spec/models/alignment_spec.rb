require 'rails_helper'

RSpec.describe Alignment, type: :model do
end

# == Schema Information
#
# Table name: alignments
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  meta       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_alignments_on_group_id  (group_id)
#
