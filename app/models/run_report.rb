class RunReport < ActiveRecord::Base
  has_many :runnable_run_report_associations, dependent: :destroy
end
