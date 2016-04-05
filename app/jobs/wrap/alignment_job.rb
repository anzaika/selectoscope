class Wrap::AlignmentJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group::ForShow.find(group_id).alignment_job
    run = Wrap::Mafft::Run.new(group_id)
    run.execute
    report = Wrap::Mafft::Report.new(run)
    report.save
  end
end