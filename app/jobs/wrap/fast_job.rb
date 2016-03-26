class Wrap::FastJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :four,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group::ForShow.find(group_id).fast_job
    run = Wrap::Fast::Run.new(group_id)
    run.execute
    report = Wrap::Fast::Report.new(run)
    report.save
  end
end
