class Webapp::ResumeViewsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :apply_records_infos
  def index
  end

  def show
  end
end
