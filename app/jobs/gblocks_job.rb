class GblocksJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :many,
                  retry:     false,
                  timeout:   10.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group.find(group_id).processed_alignment_job
    tries ||= 10
    run = Gblocks::Run.new(group_id)
    run.execute
    report = Gblocks::Report.new(run)
    report.save
  rescue Errno::EPIPE => e
    if (tries -= 1) > 0
      retry
    else
      raise e
    end
  end
end
