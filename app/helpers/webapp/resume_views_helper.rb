module Webapp::ResumeViewsHelper


  def get_resume_views(user_id)
  #   拿谁看过我的简历数据
    resume_views = ResumeView.where(user_id: user_id )
    res = []
    resume_views.each do |r|
      hospital = Hospital.find_by_id r.hospital_id
      o = {
          hospital_name:hospital.name,
          view_at:r.view_at.strftime("%y-%m-%d %H:%M:%S"),
          # scale:hospital.scale
      }
      res.push(o)
    end
    res
  end

end
