require "rails_helper"

RSpec.describe FastResult, type: :model do
  context "given a succesfull fastcodeml RunReport" do
    let(:fr) { Fabricate(:fast_result) }
    describe "::create" do
      it "creates fast_result_branch records" do
        expect(fr.branches.count > 0).to be true
      end
      it "creates fast_result_site records" do
        expect(fr.sites.count > 0).to be true
      end
      it "sets the q-value in branches" do
        expect(fr.branches.pluck(:q).all? {|v| !v.nil? }).to be true
      end
    end
  end
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
