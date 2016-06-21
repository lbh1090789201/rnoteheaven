class Api::EmployerResumesController < ApiController
  # before_action :require_employer!   # 登陆验证
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:update]

  # 必传入 job_id，
  # 按需传入 refresh_at  刷新职位
  # 按需传入 status 职位状态 1.saved 2.reviewing 3.release 4.pause 5.end 6.freeze 7.fail
  def update
    job = Job.find job_id

    if params[:refresh_at]
      job.refresh_at = Time.now
    elsif params[:status]
      job.status = params[:status]
    end

    if job.save
      render :json {
        success: true,
        info: "工作更新成功！"
      }, status: 200
    else
      render :json {
        success: false
        info: "工作更新失败。"
      }, status: 403
    end
  end

end
