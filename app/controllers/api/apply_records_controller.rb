class Api::ApplyRecordsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  # protect_from_forgery :except => [:create]
  #post to 应聘
  def create
    @apply_record = ApplyRecord.new apply_records_params
    @apply_record.user_id = current_user.id
    @apply_record.recieve_at = Time.now
    @apply_record.resume_status = "筛选"

    #简历相关
    resume = Resume.find_by_user_id current_user.id
    @apply_record.resume_id = resume.id

    #职位相关
    job = Job.find params[:apply_record][:job_id]
    @apply_record.hospital_id = job.hospital_id
    @apply_record.hospital_region =
    @apply_record.job_name = job.name
    @apply_record.job_type = job.job_type
    @apply_record.job_location = job.location
    @apply_record.salary_range = job.salary_range

    @apply_record.save
  end

  private
  def apply_records_params
    params.require(:apply_record).permit(:job_id)
  end

end
