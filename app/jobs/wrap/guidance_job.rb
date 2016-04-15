class Wrap::GuidanceJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    run = Wrap::Guidance::Run.new(group_id)
    run.execute
    report = Wrap::Guidance::Report.new(run)
    report.save
  end
end
