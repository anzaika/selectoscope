class Wrap::PhymlJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 30.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group::ForShow.find(group_id).tree_job
    run = Wrap::Phyml::Run.new(group_id)
    run.execute
    report = Wrap::Phyml::Report.new(run)
    report.save
  end

end
