class Group::ClearPipelineResultsJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :control,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(group_id)
    Group.find(group_id).clear_pipeline_results
  end
end
