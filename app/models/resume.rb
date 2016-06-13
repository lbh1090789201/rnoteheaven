class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :work_experiences
  has_many :education_experiences
  has_many :apply_records
  has_many :resume_views

  def self.refresh_left(uid)
    resume = Resume.find uid

    if resume.refresh_at && resume.refresh_at > 7.days.ago
      return ((resume.refresh_at + 7.days - Time.now)/1.day).to_i
    else
      return false
    end
  end
end
