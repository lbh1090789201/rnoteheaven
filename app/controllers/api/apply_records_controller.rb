class Api::ApplyRecordsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  protect_from_forgery :except => [:create, :update]
  #post to 应聘
  def create
    @apply_record = ApplyRecord.new apply_records_params
    @apply_record.user_id = current_user.id
    @apply_record.recieve_at = Time.now
    @apply_record.resume_status = "筛选"

    #简历相关
    resume = Resume.find_by_user_id current_user.id
    @apply_record.resume_id = resume.id if resume

    #职位相关
    job = Job.find params[:apply_record][:job_id]
    @apply_record.hospital_id = job.hospital_id
    @apply_record.hospital_region = Hospital.find(job.hospital_id).region
    @apply_record.job_name = job.name
    @apply_record.job_type = job.job_type
    @apply_record.job_location = job.location
    @apply_record.salary_range = job.salary_range

    #用户相关
    user = current_user
    @apply_record.show_name = user.show_name
    @apply_record.sex = user.sex
    @apply_record.age = ((Time.now - user.birthday)/1.year).to_i if user.birthday
    @apply_record.highest_degree = user.highest_degree
    @apply_record.start_work_at = user.start_work_at

    @apply_record.save
  end

  def update
    apply_record = ApplyRecord.find_by(user_id: params[:user_id], job_id: params[:job_id])
    apply_record.view_at = Time.now

    if apply_record.save
      render json: {
        success: true,
        info: "更新查看时间成功！"
      }, status: 200
    else
      render json: {
        success: true,
        info: "更新查看时间失败。"
      }, status: 403
    end

  end

  private

    def apply_records_params
      params.require(:apply_record).permit(:job_id, :user_id, :from)
    end

end
