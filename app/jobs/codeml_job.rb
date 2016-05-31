class CodemlJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    return nil if Group.find(group_id).codeml_job
    run = Codeml::Run.new(group_id)
    run.execute
    report = Codeml::Report.new(run)
    report.save
  end
end
