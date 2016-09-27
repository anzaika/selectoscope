class ExecuteProfile
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :many,
                  retry:     false,
                  timeout:   60.minutes,
                  backtrace: true

  def perform(args)
    ProfileExecutor.new(args)
  end
end
