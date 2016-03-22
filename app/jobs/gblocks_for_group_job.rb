class GblocksForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(group_id)
    run = Wrap::Gblocks::Run.new(group_id)
    run.execute
    report = Wrap::Gblocks::Report.new(run)
    report.save
  end
end
