class AlignmentJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue:     :many,
                  retry:     false,
                  timeout:   60.minutes,
                  backtrace: true

  def perform(rprr_id)
    rprr = ProfileReport.find(rprr_id)
    rprr.tool_for_alignment.execute(rprr_id)
  end
end
