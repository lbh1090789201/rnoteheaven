module Webapp::ResumeViewersHelper

  def get_resume_viewers(user_id)
  # 拿谁看过我的简历数据
    resume_viewers = ResumeViewer.where(user_id: user_id )
    res = []
    resume_viewers.each do |r|
      hospital = Hospital.find_by_id r.hospital_id
      job_num = Job.where(hospital_id: hospital.id, status: "release").length
      o = {
          hospital_id:r.hospital_id,
          hospital_name:hospital.name,
          view_at:r.view_at.strftime("%y-%m-%d %H:%M:%S"),
          job_num: job_num
          # scale:hospital.scale
      }
      res.push(o)
    end
    res
  end

end
