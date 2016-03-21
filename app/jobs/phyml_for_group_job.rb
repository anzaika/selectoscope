class PhymlForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 30.minutes,
                  backtrace: true

  def perform(group_id)
    run = Wrap::Phyml::Run.new(group_id)
    run.execute
    report = Wrap::Phyml::Report.new(run)
    report.save
  end

end
