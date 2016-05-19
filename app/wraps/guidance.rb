module Guidance
  def self.run(group_id)
    run = Guidance::Run.new(group_id)
    run.execute
    report = Guidance::Report.new(run)
    report.save
  end
end
