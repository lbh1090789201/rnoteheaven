include Webapp::FavoriteJobsHelper

class Webapp::FavoriteJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    @favorite_jobs = get_favorite_jobs(current_user.id)
  end
end
