# author: bobo
module Webapp::ResumeHelper

  #获取用户基本信息
  def get_user_main(user_id)
    user = User.select(:id, :show_name, :sex, :highest_degree,:start_work_at, :birthday,
                       :location, :cellphone, :email,  :seeking_job).find_by_id(user_id)
  end

  #获取工作经历
  def get_work_experience(user_id)
    work_experiences = WorkExperience.where(:user_id => user.id)

    if work_experiences.blank?
      work_experiences = WorkExperience.create(user_id: user_id)
    else
      work_experiences = work_experiences
    end

  end

  #获取教育经历
  def get_education_experience(user_id)
    education_experiences = EducationExperience.where(:user_id => user_id)

    if education_experiences.blank?
      education_experiences = EducationExperience.create(user_id: user_id)
    else
      education_experiences = education_experiences
    end
  end

  # 获取期望工作
  def get_expect_jobs(user_id)
    expect_jobs = ExpectJob.find_by_user_id(user_id)

    if expect_jobs.blank?
      expect_jobs = ExpectJob.create(user_id: user_id)
    else
      expect_jobs = expect_jobs
    end
  end


  # 数据拼装，我的简历页面
  def my_resume(user_id)

  end


end
