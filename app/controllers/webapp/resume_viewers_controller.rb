
include Webapp::ResumeViewersHelper
class Webapp::ResumeViewersController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :apply_records_infos
  def index
    @resume_view = get_resume_viewers(current_user.id)
  end
end
