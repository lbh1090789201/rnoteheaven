include Webapp::FavoriteJobsHelper

class Webapp::FavoriteJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :get_favorite_jobs
  protect_from_forgery :except => [:update]

  def index
    @favorite_jobs = get_favorite_jobs current_user.id
    @has_new = FavoriteJob.where(:has_new => true).length
  end

  def update
    favorite_job = FavoriteJob.find_by(id: params[:favor_id])
    favorite_job.has_new = params[:has_new]

    if favorite_job.save
      render json: {
        success: true,
        info: "更改成功",
      }, status: 200
    else
      render json: {
        success: true,
        info: "更改失败",
      }, status: 403
    end
  end
end
