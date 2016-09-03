module Webapp::FavoriteJobsHelper
  # 获取数据
  def get_favorite_jobs(user_id)
    ars = FavoriteJob.where( user_id: user_id )
    favorite_jobs = []
    ars.each do |a|
      job = Job.where(id: a.job_id, status: "release")

      if !job.blank?
        hospital = Hospital.find job[0].hospital_id
        o = {
            has_new: a.has_new,
            id: a.id,
            job_id:job[0].id,
            job_name:job[0].name,
            salary_range:job[0].salary_range,
            location:job[0].location,
            hospital: hospital.name
        }
        favorite_jobs.push(o)
      end
    end
    favorite_jobs
  end
end
