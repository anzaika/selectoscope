class MafftForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 30.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id)
    mafft = Wrap::Mafft.new(group.fasta_file)
    mafft.execute()
    link_report(group_id, mafft.run_report.id)
    link_alignment(group, mafft) if mafft.succ
  end

  def link_report(group_id, run_report_id)
    RunnableRunReportAssociation
      .create(
        runnable_type: 'group',
        runnable_id: group_id,
        run_report_id: run_report_id)
  end

  def link_alignment(group, mafft)
    group.alignments << mafft.alignment
  end

end
