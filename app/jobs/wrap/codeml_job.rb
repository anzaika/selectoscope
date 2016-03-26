class Wrap::CodemlJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group::ForShow.find(group_id).codeml_job
    run = Wrap::Codeml::Run.new(group_id)
    run.execute
    report = Wrap::Codeml::Report.new(run)
    report.save
  end
end
