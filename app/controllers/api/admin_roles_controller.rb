class Api::AdminRolesController < ApplicationController
  before_action :require_admin! # 登陆验证
  protect_from_forgery :except => [:update]

  def update
    user = User.find role_params[:id]
    user.show_name = params[:show_name]
    user.user_type = params[:role]

    role = ":" + params[:role]
    user.add_role role

    if user.save
      render json: {
        success: true,
        info: '用户权限修改成功！',
        user: user
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
