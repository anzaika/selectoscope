class GblocksForGroupJob

  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(group_id)
    tries ||= 5
    run = Wrap::Gblocks::Run.new(group_id)
    run.execute
    report = Wrap::Gblocks::Report.new(run)
    report.save
  rescue Errno::EPIPE => e
    (tries -= 1) > 0 ? retry : raise e
  end

end
