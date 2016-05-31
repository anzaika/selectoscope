module Fastcodeml
  def self.run(group_id)
    return nil if Group.find(group_id).fast_job
    run = Fastcodeml::Run.new(group_id)
    run.execute
    report = Fastcodeml::Report.new(run)
    report.save
    FastResult.create(group_id: group_id)
  end
end
