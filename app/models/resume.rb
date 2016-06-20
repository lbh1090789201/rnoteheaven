class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :work_experiences
  has_many :education_experiences
  has_many :apply_records
  has_many :resume_views

  def self.refresh_left(rid)
    resume = Resume.find rid

    if resume.refresh_at && resume.refresh_at > 7.days.ago
      return ((resume.refresh_at + 7.days + 1.hours - Time.now)/1.day).to_i
    else
      return false
    end
  end

  def self.info(uid)
    resume = Resume.find_by user_id: uid

    expect_job = ExpectJob.find_by(user_id: uid).name
    info = User.select(:id, :show_name, :sex, :highest_degree, :start_work_at, :birthday).find(uid).as_json
    info[:expect_job] = expect_job
    info[:age] = ((Time.now - info["birthday"])/1.year).to_i if info["birthday"]
    info[:resume_id] = resume.id if resume

    return info.as_json
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
