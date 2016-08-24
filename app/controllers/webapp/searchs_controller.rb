class Webapp::SearchsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :get_searchs

  def index
    if params[:search]
      jobs = Job.filter_job_status("release")
                .filter_job_name(params[:name])
                .filter_location(params[:region])
                .filter_salary_range(params[:salary_range])
                .filter_job_experience(params[:experience])
                .filter_degree_demand(params[:degree_demand])
                .filter_recruit_type(params[:recruit_type])
      hospitals = Hospital.filter_hospital_name(params[:name])
                          .filter_location(params[:region])

      @jobs = []
      if !jobs.blank?
        jobs.each do |j|
          @jobs.push j
        end
      else
        hospitals.each do |h|
          job_all = Job.filter_job_status("release")
                       .where(hospital_id: h.id)
                       .filter_salary_range(params[:salary_range])
                       .filter_job_experience(params[:experience])
                       .filter_degree_demand(params[:degree_demand])
                       .filter_recruit_type(params[:recruit_type])
          job_all.each do |j|
            @jobs.push j
          end
        end
      end

      @arrjob = []
      @jobs.each do |r|
        hospital = Hospital.find_by_id r.hospital_id
        o = {
          id: r.id,
          job_name: r.name,
          salary_range: r.salary_range,
          region: r.region,
          hospital_name: hospital.name,
          city: params[:region]
        }
        @arrjob.push(o)
      end

      render json: {
        success: true,
        info: "搜索成功！",
        jobs: @arrjob.as_json,
      }, status: 200
    end
  end

end
