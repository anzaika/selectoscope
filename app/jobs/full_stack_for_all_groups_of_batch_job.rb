class FullStackForAllGroupsOfBatchJob
  include Sidekiq::Worker
  sidekiq_options queue: :one, retry: 2, timeout: 10.minutes

  def perform(batch_id)
    ids = Batch.find(batch_id).groups.pluck(:id)
    ids.each {|id| AlignmentForGroupJob.perform_async(id) }
    ids.each {|id| GblocksForGroupJob.perform_later(id) }
    ids.each {|id| PhymlForGroupJob.perform_later(id) }
    ids.each {|id| CodemlForGroupJob.perform_later(id) }
    ids.each {|id| FastForGroupJob.perform_later(id) }
  end
end
