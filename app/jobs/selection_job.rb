class SelectionJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :four,
                  retry:     false,
                  backtrace: true

  def perform(profile_report_id)
    ProfileReport.find(profile_report_id).execute_tool_for_selection
  end
end
