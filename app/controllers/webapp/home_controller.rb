class Webapp::HomeController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    filter = params

    #只搜索城市
    if filter[:city]
      @jobs = Job.filter_location(filter[:city])
    else
      @jobs = Job.filter_location("深圳")
    end

    #搜索城市和医院
    if filter[:city] && filter[:search] && !filter[:search].blank?
      job_careers = Job.filter_location(filter[:city]).filter_job_name(filter[:search])
      hospitals = Hospital.filter_location(filter[:city]).filter_hospital_name(filter[:search])
      @jobs = []
      if !job_careers.blank?
        job_careers.each do |j|
          @jobs.push(j)
        end
      else
        hospitals.each do |h|
          job_all = Job.where(:hospital_id => h.id)
          job_all.each do |j|
            @jobs.push(j)
          end
        end
      end
    end

      @arjob = []
      @jobs.each do |r|
        hospital = Hospital.find_by_id r.hospital_id
        o = {
          id: r.id,
          job_name: r.name,
          salary_range: r.salary_range,
          location: r.location,
          hospital_name: hospital.name
        }
        @arjob.push(o)
      end
    # puts "....."+@arjob.to_json.to_s
    return @arjob
  end
end
