class Admin::JobsController < AdminController
  before_action :require_jobs_manager!
  protect_from_forgery :except => [:update]

  def index
    if params[:search]
      jobs = Job.where.not(status: ['reviewing', 'saved'])
                 .filter_job_status(params[:status])
                 .filter_release_before(params[:time_before])
                 .filter_release_after(params[:time_after])
                 .filter_job_type(params[:job_type])
                 .filter_hospital_name(params[:hospital_name])
                 .filter_job_name(params[:job_name])

      @jobs = Job.get_job_info jobs

      render json: {
        success: true,
        info: '搜索成功',
        jobs: @jobs
      }, status: 200
    else
      jobs = Job.where.not(status: ['reviewing', 'saved'])
      @jobs = Job.get_job_info jobs
    end
  end

  def check
    if params[:search]
      jobs = Job.filter_job_status('reviewing')
                 .filter_create_begin(params[:time_after])
                 .filter_create_end(params[:time_before])
                 .filter_job_type(params[:job_type])
                 .filter_hospital_name(params[:hospital_name])
                 .filter_job_name(params[:job_name])

      @jobs = Job.get_job_info jobs
      render json: {
        success: true,
        info: '搜索成功',
        jobs: @jobs
      }, status: 200
    else
      jobs = Job.filter_job_status('reviewing')
      @jobs = Job.get_job_info jobs

    end

  end

  def show

    @job = Job.find params[:id]

    render json: {
      success: true,
      info: '获取job成功',
      job: @job,
    }, status: 200
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

        EventLog.create_log current_user.id, current_user.show_name, 'Job', j.id, "工作", btn_params[:status]
      end

      if btn_params[:status] == 'release'
        jobs = Job.filter_job_status('reviewing')
        @jobs = Job.get_job_info jobs
      else
        jobs = Job.where.not(status: ['reviewing', 'saved'])
        @jobs = Job.get_job_info jobs
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


  private
    def btn_params
      params.permit(:ids, :status)
    end

    def search_params
      params.permit(:search, :time_before, :time_after, :job_type, :hospital_name, :job_name, :status)
    end
end
