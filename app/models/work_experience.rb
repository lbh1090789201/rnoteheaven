class WorkExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :user
end
