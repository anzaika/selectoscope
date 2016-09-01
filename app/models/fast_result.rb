class FastResult < ActiveRecord::Base
  belongs_to :profile_report
  has_many :fast_result_branches, dependent: :destroy
  has_many :fast_result_sites, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy

  after_create :parse_output
  after_create :set_branch_q_values

  alias_attribute :branches, :fast_result_branches
  alias_attribute :sites, :fast_result_sites

  private

  def parse_output
    out = FastOutput::Output.new(profile_report.tool_reports.last)
    return nil unless out
    create_branches(out)
    create_sites(out)
    create_tree(out)
  end

  def create_branches(out)
    out.branches.each do |b|
      FastResultBranch.create(
        fast_result: self,
        number:      b.number,
        l0:          b.l0,
        l1:          b.l1,
        positive:    b.positive?,
        q:           b.q
      )
    end
  end

  def create_sites(out)
    out.sites.each do |s|
      FastResultSite.create(
        fast_result: self,
        branch:      s.branch,
        position:    s.position,
        probability: s.probability
      )
    end
  end

  def create_tree(out)
    Tree.create(
      treeable: self,
      newick:   out.tree_with_positive.newick
    )
  end

  def set_branch_q_values
    l0 = branches.map(&:l0)
    l1 = branches.map(&:l1)
    qvalues = QValues.create(l0: l0, l1: l1).to_a
    branches.each_with_index {|b, i| b.update_attribute(:q, qvalues[i]) }
  end
end

# == Schema Information
#
# Table name: fast_results
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  has_positive      :boolean
#  profile_report_id :integer
#
# Indexes
#
#  index_fast_results_on_profile_report_id  (profile_report_id)
#
