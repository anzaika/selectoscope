class PhymlJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :many,
                  retry:     false,
                  backtrace: true

  def perform(group_id)
    Phyml.run(group_id)
  end
end
