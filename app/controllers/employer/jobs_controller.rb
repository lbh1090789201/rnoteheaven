class Employer::JobsController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
    @hospital = Employer.get_hospital current_user.id
    @jobs = Job.where(hospital_id: @hospital.id)
  puts "--------"+@jobs.to_json.to_s
    @jobs.each do |f|
      f.status = "end" if Time.new > f.end_at
      f.save
    end

  end

  def show
    @job = Job.find params[:id]
    @hospital = Employer.get_hospital current_user.id
    @seeker_count = ApplyRecord.where(job_id: @job.id).length
    @time_left = Job.time_left @job.id
    @left_refresh_time = Job.left_refresh_time @job.id
  end

  def create
    job = Job.new job_params
    job.release_at = Time.now
    job.refresh_at = Time.now

    if job.save
      render js: "location.href=document.referrer;"
    else
      render json: {
        success: false,
        info: "工作发布失败"
      }, status: 403
    end
  end

  def update
    job = Job.find params[:id]

    if  Job.update job_params && job.save
      # 通知用户，职位信息有更新
      res = FavoriteJob.set_new job.id
      render js: "location.href=document.referrer"
    else
      render json: {
        success: false,
        info: "工作更新失败"
      }, status: 403
    end
  end

  def destroy
    job = Job.find params[:id]

    if job.destroy
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

  private

    def job_params
      params.require(:job).permit(:name, :job_type, :salary_range, :experience, :needed_number,
                                  :region, :location, :job_desc, :job_demand, :status, :release_at, :end_at)
    end
end


# 接口说明
# @time_left 发布剩余时间 integer 5
# @left_refresh_time 刷新职位剩余时间 5 / -1(可再次刷新)
