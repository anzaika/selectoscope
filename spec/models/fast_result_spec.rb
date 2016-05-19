require "rails_helper"

RSpec.describe FastResult, type: :model do
end

# == Schema Information
#
# Table name: fast_results
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  has_positive  :boolean
#  run_report_id :integer          not null
#
# Indexes
#
#  index_fast_results_on_run_report_id  (run_report_id)
#
