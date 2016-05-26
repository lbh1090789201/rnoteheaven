# author: bobo
module Webapp::ResumeHelper

  #获取User对应的数据
  def get_user_by_id(user_id)
    user = User.select(:id, :show_name, :sex, :highest_degree,:start_work_at, :birthday,
                                :location, :cellphone, :email,  :seeking_job).find_by_id(user_id)
  end

  #获取工作经历
  def get_work_experience_by_id(user_id)
    # work_experience = WorkExperience.select()
  end
end
