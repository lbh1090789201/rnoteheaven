include Webapp::FavoriteJobsHelper

class Webapp::FavoriteJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :get_favorite_jobs

  def index
    @favorite_jobs = get_favorite_jobs(current_user.id)
    puts 'sssss' + @favorite_jobs.to_json.to_s
  end
end
