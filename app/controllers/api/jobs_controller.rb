class Api::JobsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  #post to search
  def search
    #query_by_filter(params[:filter])
  end

  def index
  end

  def show
    @job = Job.find_by_id(params[:id])
  end

  # private
  # def job_params
  #   params.require(:job).permit(:name, :job_type, :salary_range, :location)
  # end

end
