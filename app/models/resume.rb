class Resume < ActiveRecord::Base
  belongs_to :user

  has_many :work_experiences
  has_many :education_experiences
  has_many :apply_records
  has_many :resume_views

  default_scope { order('refresh_at DESC') }

  # 按 完整度 筛选
  scope :filter_maturity, -> (num){
     where("maturity > ?", num) if num.present?
   }

  # 按 未冻结 筛选
  scope :filter_no_freeze, -> { where(resume_freeze: false)  }

  # 按 冻结 筛选
  scope :filter_is_freeze, -> { where(resume_freeze: true)  }

  # 按 公开 筛选
  scope :filter_is_public, -> (status){
    where(public: status) if status.present?
  }

  # 按 是否被屏蔽筛选
  scope :filter_is_block, -> (hid){
    items = BlockHospital.where(hospital_id: hid)
    user_ids = []
    items.each do |f|
      user_ids.push f.user_id
    end

    where.not(user_id: user_ids)
  }

  # 按 用户所在地 筛选
  scope :filter_by_city, -> (city){
    includes(:user).where(users: {location: city}) if city.present?
   }

  # 按 用户名 搜索
  scope :filter_show_name, -> (name){
    includes(:user).where('users.show_name LIKE ?', "%#{name}%").references(:user) if name.present?
   }

  # 获取剩余刷新时间
  def self.refresh_left(rid)
    resume = Resume.find rid

    if resume.refresh_at && resume.refresh_at > 7.days.ago
      return ((resume.refresh_at + 7.days + 1.hours - Time.now)/1.day).to_i
    else
      return false
    end
  end

  # 获取简历拥有者个人信息
  def self.info(uid)
    resume = Resume.find_by user_id: uid

    expect_job = ExpectJob.find_by(user_id: uid).name if ExpectJob.find_by(user_id: uid)
    info = User.select(:id, :show_name, :sex, :highest_degree, :start_work_at, :birthday).find(uid).as_json
    info[:expect_job] = expect_job
    info[:age] = info["birthday"] ? ((Time.now - info["birthday"])/1.year).to_i : 0
    info[:resume_id] = resume.id

    return info.as_json
  end

  # Admin 获取简历相关信息
  def self.get_info resume
    res = resume.as_json
    user = User.find resume.user_id
    apply_count = ApplyRecord.where(user_id: user.id).length
    viewed_count = ResumeViewer.where(user_id: user.id).length

    res["show_name"] = user.show_name
    res["location"] = user.location
    res["apply_count"] = apply_count
    res["viewed_count"] = viewed_count

    return res
  end

  # admin 获取某个简历的详细信息
  def self.get_resume_info resume_id
    resume = Resume.find resume_id
    user = User.find resume.user_id
    education_experiences = EducationExperience.where(user_id: user.id)
    work_experiences = WorkExperience.where(user_id: user.id)
    certificates = Certificate.where(user_id: user.id)
    expect_job = ExpectJob.find_by user_id: user.id
    apply_count = ApplyRecord.where(user_id: user.id).length
    viewed_count = ResumeViewer.where(user_id: user.id).length
    user.avatar_url.blank? ? avatar = "avator.png" : avatar = user.avatar_url

    @resume = {
      id: resume.id,
      apply_count: apply_count,
      viewed_count: viewed_count,
      user: user,
      name: expect_job.name,
      job_type: expect_job.job_type,
      location: expect_job.location,
      expected_salary_range: expect_job.expected_salary_range,
      job_desc: expect_job.job_desc,
      education_experiences: education_experiences,
      work_experiences: work_experiences,
      certificates: certificates,
      avatar: avatar,
    }
    return @resume
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
