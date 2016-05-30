class Webapp::ResumeViewsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
  end

  def show
  end
end
