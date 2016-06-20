class Api::EmployerResumesController < ApiController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:update]

  def update
    
  end

end
