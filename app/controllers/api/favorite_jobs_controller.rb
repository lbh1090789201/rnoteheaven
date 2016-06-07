class Api::FavoriteJobsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  #post to search
  def create
    @favorite_job = FavoriteJob.new favorite_job_params
    @favorite_job.user_id = current_user.id
    #....
    @favorite_job.save
  end

  private
  def favorite_job_params
    params.require(:favorite_job).permit(:job_id)
  end
end
