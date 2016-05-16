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
# Indexes
#
#  index_fast_results_on_group_id  (group_id)
#

class FastResult < ActiveRecord::Base
  belongs_to :group
  has_many :run_reports, through: :group
  has_many :fast_result_branches, dependent: :destroy
  has_many :fast_result_sites, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy

  after_create :parse_output

  alias_attribute :branches, :fast_result_branches
  alias_attribute :sites, :fast_result_sites

  private

  def parse_output
    out = FastOutput::Output.new(run_reports.find_by(program: "Fastcodeml"))
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
end
