class Hospital < ActiveRecord::Base
  has_many :jobs
  has_many :resume_views
end
