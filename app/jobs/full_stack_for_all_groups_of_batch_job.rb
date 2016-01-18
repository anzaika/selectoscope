class FullStackForAllGroupsOfBatchJob
  include Sidekiq::Worker
  sidekiq_options queue: :control,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(batch_id)
    ids = Batch.find(batch_id).groups.pluck(:id)
    ids.each {|id| RunFullStackJob.perform_async(id) }
  end
end
