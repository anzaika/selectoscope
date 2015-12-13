class RunReport < ActiveRecord::Base
  belongs_to :runnable, polymorphic: true
end
