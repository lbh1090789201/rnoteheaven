class Api::AdminRolesController < ApiController
  before_action :authenticate_user!   # 登陆验证

  def update
    user = User.find role_params[:id]
    user.show_name = params[:show_name]

    role = ":" + params[:role]
    if user.save && user.add_role role
      render json: {
        success: true,
        info: '用户权限修改成功！',
        user: user.to_json
      }, status: 200
    else
      render json: {
        success: false,
        info: '用户权限修改失败。'
      }, status: 403
    end

  end

  private
    def role_params
      params.permit(:show_name, :role, :id)
    end
end
