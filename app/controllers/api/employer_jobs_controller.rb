class Api::EmployerJobsController < ApiController
  # before_action :require_employer!   # 登陆验证
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:update, :destroy, :view_update]

  # 必传入 job_id，
  # 按需传入 refresh_at  刷新职位
  # 按需传入 status 职位状态 1.saved 2.reviewing 3.release 4.pause 5.end 6.freeze 7.fail
  # 再次发布需传入 status: "release_again", duration: 14 (数字)
  def update
    job = Job.find params[:job_id]

    if params[:refresh_at]
      job.refresh_at = Time.now
    elsif params[:status] == "reviewing"
      job.submit_at = Time.now
      job.status = params[:status]
    elsif params[:status] == "release_again"
      job.operate_at = Time.now
      job.end_at = Time.now + (params[:duration]).to_i.days
      job.status = "release"
    else
      job.status = params[:status]
    end

    if job.save
      render json: {
        success: true,
        info: "工作更新成功！",
      }, status: 200
    else
      render json: {
        success: false,
        info: "工作更新失败。",
      }, status: 403
    end
  end

  # 医院端查看了 Admin 的更新
  def view_update
    job = Job.find params[:job_id]
    job.is_update = false

    if job.save
      render json: {
        success: true,
        info: "查看更新成功！",
      }, status: 200
    else
      render json: {
        success: false,
        info: "查看更新失败。",
      }, status: 403
    end
  end

  def destroy
    job = Job.find params[:id]

    if job.destroy
      render js: "location.href = document.referrer"
    else
      render json: {
        success: false,
        info: "工作删除失败。",
      }, status: 403
    end
  end

end
