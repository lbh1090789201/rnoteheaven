class Webapp::FavoriteJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
end
