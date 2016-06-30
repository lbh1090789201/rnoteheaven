class Admin::JobsController < ApplicationController
  before_action :require_admin!
  layout 'admin'
  protect_from_forgery :except => [:update]

  def index

  end

  def check
    if params[:search]
      @jobs = Job.filter_job_status('reviewing')
                 .filter_release_before(params[:time_before])
                 .filter_release_before(params[:time_after])
                 .filter_job_type(params[:job_type])
                 .filter_hospital_name(params[:hospital_name])
                 .filter_job_name(params[:job_name])

      render json: {
        success: true,
        info: '搜索成功',
        jobs: @jobs
      }, status: 200
    else
      @jobs = Job.filter_job_status('reviewing').as_json
      # @test = Job.filter_job_status('release').as_json
      # puts '-----------' + @test.to_json.to_s
    end
  end

  def update
    if btn_params[:ids] && !btn_params[:ids].blank?
      ids = btn_params[:ids].split(',')
      jobs = Job.where(id: ids)

      jobs.each do |j|
        j.status = btn_params[:status]
        j.save
      end

      @jobs = Job.filter_job_status('reviewing').as_json

      render json: {
        success: true,
        info: '审批成功',
        jobs: @jobs
      }, status: 200
    else
      render json: '审批失败，检查您是否勾选职位', status: 403
    end

  end

  def edit

  end

  private
    def btn_params
      params.permit(:ids, :status)
    end

    def search_params
      params.permit(:search, :time_before, :time_after, :job_type, :hospital_name, :job_name)
    end
end
