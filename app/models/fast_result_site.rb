class FastResultSite < ActiveRecord::Base
  belongs_to :fast_result

  default_scope -> { order(probability: :desc) }
end

# == Schema Information
#
# Table name: fast_result_sites
#
#  id             :integer          not null, primary key
#  fast_result_id :integer          not null
#  branch         :integer          not null
#  position       :integer          not null
#  probability    :decimal(7, 6)    not null
#
# Indexes
#
#  index_fast_result_sites_on_fast_result_id  (fast_result_id)
#
