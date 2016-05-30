include Webapp::FavoriteJobsHelper

class Webapp::FavoriteJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    @favorite_jobs = get_favorite_jobs(current_user.id)
    puts 'kkkkkkk' + @favorite_jobs.to_json.to_s
  end
end
