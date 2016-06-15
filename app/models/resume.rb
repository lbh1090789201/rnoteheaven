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

  # 获得完整度
  def self.get_maturity uid
    resume = Resume.find_by user_id: uid
    if resume.nil?
      resume = Resume.create(user_id: uid, maturity: 0)
      return 0
    else
      user = User.find uid
      education_experience = EducationExperience.find_by user_id: uid
      expected_job = ExpectJob.find_by user_id: uid
      resume.maturity = 0

      if  user.sex && user.highest_degree && user.position && user.start_work_at &&
          user.birthday && !user.cellphone.blank? && user.email && user.location

        resume.maturity += 25
      end

      if user.avatar
        resume.maturity += 25
      end

      if education_experience
        resume.maturity += 25
      end

      if  expected_job && expected_job.name && expected_job.job_type &&
          expected_job.location && expected_job.expected_salary_range

        resume.maturity += 25
      end

      resume.save!
      return resume.maturity
    end
  end

end
