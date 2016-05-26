class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :work_experiences
  has_many :education_experiences
  has_many :apply_records
  has_many :resume_views
end
