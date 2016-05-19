class Group::FullStackJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :control,
                  retry:     false,
                  timeout:   600.minutes,
                  backtrace: true

  def perform(group_id)
    check_group_preprocessing_done(group_id)
    jid = GuidanceJob.perform_async(group_id)
    at(20, "Alignment complete")
    job_status(interval: 5, jid: jid) &&
      jid = PhymlJob.perform_async(group_id)
    at(40, "Gblocks complete")
    job_status(interval: 10, jid: jid) &&
      jid = CodemlJob.perform_async(group_id)
    at(60, "PhyML complete")
    job_status(interval: 10, jid: jid) &&
      jid = FastcodemlJob.perform_async(group_id)
    at(80, "CodeML complete")
  end

  def job_status(interval:, jid:)
    loop do
      if Sidekiq::Status.complete?(jid)
        break
      elsif Sidekiq::Status.failed?(jid)
        raise
      else
        sleep(interval)
      end
    end
    true
  end

  def check_group_preprocessing_done(group_id)
    g = Group.find(group_id)
    attempts = 0
    loop do
      if attempts < 10 && !g.preprocessing_done
        attempts += 1
        sleep(2)
      elsif attempts < 10 && g.preprocessing_done
        break
      elsif attempts > 10
        raise "Group #{group_id} preprocessing hasn't finished hence can't start the pipeline." if attempts > 10
      end
    end
  end
end
