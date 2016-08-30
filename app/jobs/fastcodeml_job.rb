class FastcodemlJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :four,
                  retry:     false,
                  backtrace: true

  def perform(group_id)
    Fastcodeml.new(group_id).run
  end
end
