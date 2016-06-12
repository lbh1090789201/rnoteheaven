class Api::FavoriteJobsController < ApiController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:create, :destroy]

  def create
    @favorite_job = FavoriteJob.new favorite_job_params
    @favorite_job.user_id = current_user.id

    #job
    job = Job.find favorite_job_params[:job_id]
    @favorite_job.name = job.name
    @favorite_job.job_type = job.job_type
    @favorite_job.salary_range = job.salary_range

    #hospital
    hospital = Hospital.find job.hospital_id
    @favorite_job.region = hospital.region

    @favorite_job.save
  end

  def destroy
    favorite_job = FavoriteJob.find_by_job_id params[:id]

    if favorite_job.destroy
      render json: {
                 success: true,
                 info: '取消收藏成功！'
             }, status: 200
    else
      render json: {
                 success: false,
                 info: '取消收藏失败'
             }, status: 403
    end
  end

  private
  def favorite_job_params
    params.require(:favorite_job).permit(:job_id)
  end
end
