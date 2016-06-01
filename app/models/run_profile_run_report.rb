class RunProfileRunReport < ActiveRecord::Base
  belongs_to :group
  belongs_to :run_profile

  has_many :tools, through: :run_profile

  delegate :tool_for_alignment, to: :run_profile
  delegate :tool_for_tree, to: :run_profile
  delegate :tool_for_selection, to: :run_profile

  has_many :tool_run_reports, dependent: :nullify

  has_one :tree, as: :treeable, dependent: :destroy
  has_one :codeml_result, dependent: :destroy
  has_one :fast_result, dependent: :destroy

  def run_pipeline
    run_alignment
    run_tree
    run_selection
  end

  def run_alignment
    fasta = group.fasta_file.to_fasta_string
    tool_for_alignment.execute(fasta)
  end

  def alignment
    ToolForAlignment.result_for(
      tool_run_reports.for_alignment.first
    )
  end
end

# == Schema Information
#
# Table name: run_profile_run_reports
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  run_profile_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
