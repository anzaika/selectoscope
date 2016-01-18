class RunFullStackJob
  include Sidekiq::Worker
  sidekiq_options queue: :control,
                  retry: false,
                  timeout: 600.minutes,
                  backtrace: true

  def perform(group_id)
    jid = AlignmentForGroupJob.perform_async(group_id)
    job_status(interval: 2, jid: jid) &&
      jid = GblocksForGroupJob.perform_async(group_id)
    job_status(interval: 1, jid: jid) &&
      jid = PhymlForGroupJob.perform_async(group_id)
    job_status(interval: 10, jid: jid) &&
      jid = CodemlForGroupJob.perform_async(group_id)
    job_status(interval: 10, jid: jid) &&
      jid = FastForGroupJob.perform_async(group_id)
  end

  def job_status(interval:, jid:)
    while true
      if Sidekiq::Status::complete?(jid)
        break
      elsif Sidekiq::Status::failed?(jid)
        raise
      else
        sleep(interval)
      end
    end
    true
  end

end
