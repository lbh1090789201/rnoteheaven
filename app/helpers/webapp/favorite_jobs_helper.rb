module Webapp::FavoriteJobsHelper
  # 获取数据
  def get_favorite_jobs(user_id)
    ars = FavoriteJob.where( user_id: user_id )
    favorite_jobs = []
    ars.each do |a|
      job = Job.find_by_id a.job_id
      if job
      o = {
          job_name:job.name,
          salary_range:job.salary_range,
          location:job.location,
      }
      favorite_jobs.push(o)
      end
      end
    favorite_jobs
  end

end
