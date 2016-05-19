module Phyml
  def self.run(group_id)
    return nil if Group::ForShow.find(group_id).tree_job
    run = Phyml::Run.new(group_id)
    run.execute
    report = Phyml::Report.new(run)
    report.save
  end
end
