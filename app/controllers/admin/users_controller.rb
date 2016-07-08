class Admin::UsersController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index
    if params[:search]
      #
      @users = User.filter_create_before(params[:time_to])
                   .filter_create_after(params[:time_from])
                   .where('show_name LIKE ?', "%#{params[:show_name]}%")
                   .filter_by_role(params[:role])
      puts '---------------' + @users.to_json.to_s
      render json: {
        success: true,
        info: '搜索成功',
        users: @users
      }, status: 200
    else
      @users = User.all
    end
  end

  def record
  end

  def  create

  end

  def update
  end
end
