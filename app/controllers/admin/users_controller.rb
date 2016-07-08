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
    id = User.last.id + 1

    new_platinum = {
      user_type: "platinum",
      username: "platinum" + id.to_s,
      password: password[:password],
      show_name: params[:show_name],
      email: "platinum" + id.to_s + "@example.com"
    }

    @user = User.create! new_platinum
    params[:scopes].each do |f|
      Role.set_platinum @user, f
    end
  end

  def update
  end

end
