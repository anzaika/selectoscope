class RunnableRunReportAssociation < ActiveRecord::Base
  belongs_to :runnable, polymorphic: true
  belongs_to :run_report
end
