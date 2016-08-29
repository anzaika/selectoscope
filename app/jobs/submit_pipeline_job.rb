class SubmitPipelineJob
  include Sidekiq::Worker
  sidekiq_options queue:     :control,
                  retry:     false,
                  timeout:   10.minutes,
                  backtrace: true

  def perform(group_id, profile_id)
    Group.find(group_id).profile(profile_id)
  end
end
