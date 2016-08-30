class TreeJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :many,
                  retry:     false,
                  timeout:   60.minutes,
                  backtrace: true

  def perform(profile_report_id)
    ProfileReport.find(profile_report_id).execute_tool_for_tree
  end
end
