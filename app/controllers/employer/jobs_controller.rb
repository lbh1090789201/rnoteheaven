class Employer::JobsController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    @vip_status = Employer.get_status current_user.id
  end

  def index
    check_vip = Employer.check_vip current_user.id
    @hospital = Employer.get_hospital current_user.id
    @jobs = Job.where(hospital_id: @hospital.id).where.not(status: 'delete')

    @jobs.each do |f|
      if f.status == 'release' || f.status == 'pause'
        f.status = "end" if (Time.now > f.end_at)
        f.save
      end
    end
  end

  def new

  end

  def show
    @job = Job.find params[:id]
    @job_sate = {id: @job.id, status: @job.status}
    @btn_txt = get_txt @job.status
    @hospital = Employer.get_hospital current_user.id
    @seeker_count = ApplyRecord.where(job_id: @job.id).length
    @time_left = Job.time_left @job.id
    @left_refresh_time = Job.left_refresh_time @job.refresh_at
  end

  def edit
    @job = Job.find params[:id]

    if @job.end_at
      @job_end_at = ((@job.end_at - Time.now)/1.days).to_i
    else
      @job_end_at = @job.duration
    end
  end

  def create
    job = Job.new job_params
    job.hospital_id = Employer.get_hospital(current_user.id).id

    if job_params[:status] == "reviewing"
      job.submit_at = Time.now
    end

    if job.save
      render js: 'location.href = document.referrer'
    else
      render js: 'alert("请检查信息是否填写完整")'
    end
  end

  def update
    job = Job.find params[:id]
    # job.end_at = Time.now + job_params[:duration].to_i.days
    job.submit_at = Time.now

    if job.save && job.update_columns(job_params)
      # 通知用户，职位信息有更新
      res = FavoriteJob.set_new job.id
      render js: "history.go(-2);"
      # 更新job时更新apply_record的冗余信息
      ApplyRecord.job_update_record job
    else
      render json: {
        success: false,
        info: "工作更新失败"
      }, status: 403
    end
  end

  def destroy
    job = Job.find params[:id]
    job.status = 'delete'
    if job.save
      render json: {
        success: true,
        info: "删除成功"
      }, status: 200
    else
      render json: {
        success: false,
        info: "删除失败"
      }, status: 403
    end
  end

  def preview
    @job = Job.find params[:id]
  end

  private

    def job_params
      params.permit(:name, :job_type, :salary_range, :experience, :needed_number,:is_top,
                              :duration, :region, :location, :job_desc, :job_demand, :status,
                              :release_at, :recruit_type, :degree_demand)
    end

    # 按钮显示名称
    def get_txt status
      txt = {}
      txt[:pause] = "暂停发布"

      if status == "release"
        txt[:release] = "已经发布"
      elsif status == "pause"
        txt[:release] = "继续发布"
      elsif status == "end"
        txt[:release] = "再次发布"
      else
        txt[:release] = "提交审核"
      end

      if ["saved", "fail"].include?(status)
        txt[:end] = "删除职位"
      else
        txt[:end] = "结束发布"
      end

      return txt
    end
end



# 接口说明
# @time_left 发布剩余时间 integer 5
# @left_refresh_time 刷新职位剩余时间 5 / -1(可再次刷新)
