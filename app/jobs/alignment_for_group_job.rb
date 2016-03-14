class AlignmentForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id)
    vault = Vault.new
    run = Wrap::Mafft::Run.new(vault, group.fasta_file)
    run.execute
    report = Wrap::Mafft::Report.new(vault, run)
    report.save

    report.run_report.update_attribute(:user_id, group.user_id)
    group.run_reports << report.run_report
    group.alignments << report.alignment
  end
end
