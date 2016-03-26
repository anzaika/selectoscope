class Group::ProcessIdentifiersJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(group_id)
    Group.find(group_id).process_identifiers
  end
end
