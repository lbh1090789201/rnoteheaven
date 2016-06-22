class Api::EmployerViewersController < ApiController
  # before_action :require_employer!   # 登陆验证
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:create]

  # 需要传入 user_id
  # 待测试
  def create
    hospital = Employer.get_hospital current_user.id

    render ResumeViewer.set_viewer(hospital.id, params[:user_id])
  end

end
