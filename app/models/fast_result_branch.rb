class FastResultBranch < ActiveRecord::Base
  belongs_to :fast_result
end

# == Schema Information
#
# Table name: fast_result_branches
#
#  id             :integer          not null, primary key
#  fast_result_id :integer          not null
#  number         :integer          not null
#  l0             :decimal(16, 11)
#  l1             :decimal(16, 11)
#  positive       :boolean
#  q              :decimal(16, 11)
#
# Indexes
#
#  index_fast_result_branches_on_fast_result_id_and_positive  (fast_result_id,positive)
#
