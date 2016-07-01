class Admin::JobsController < ApplicationController
  before_action :require_admin!
  layout 'admin'
  protect_from_forgery :except => [:update]

  def index
    if params[:search]
      @jobs = Job.where.not(status: 'reviewing')
                 .filter_job_status(params[:status])
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
      @jobs = Job.where.not(status: 'reviewing').as_json
    end
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
    end
  end

  def update
    if btn_params[:ids] && !btn_params[:ids].blank?
      ids = btn_params[:ids].split(',')
      jobs = Job.where(id: ids)

      jobs.each do |j|
        j.status = btn_params[:status]
        j.operate_at = Time.now
        j.end_at = Time.now + (j.duration).days
        j.is_update = true
        j.save
      end

      if btn_params[:status] == 'reviewing'
        @jobs = Job.filter_job_status('reviewing').as_json
      else
        @jobs = Job.where.not(status: 'reviewing')
      end

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
      params.permit(:search, :time_before, :time_after, :job_type, :hospital_name, :job_name, :status)
    end
end
