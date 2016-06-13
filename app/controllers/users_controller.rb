class UsersController < ApplicationController
  #before_filter :authenticate_user_from_token!, except: [:forgot_password]
  #bafore_filer代表需要加载请求头　except代表除开它指定的请求外其它都需要
  #bafore_filer注释后就整个不需要加载请求头
  # before_filter :authenticate_user!, except: [:forgot_password]
  
  def index
    @user = User.new
  end
  def show
    @user = User.friendly.find(params[:id])

  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  # GET /buildings/1/edit
  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  def code
    if Rails.env == "production"
      @url = '/users/sign_up?openid='+params[:openid]+'&sex='+params[:sex]+'&show_name='+params[:show_name]+'&avatar_url=' +params[:avatar_url] +'&unionid='+params[:unionid]
    else
      @url = '/users/sign_up'
    end
  end

  def check_username_usertype
    username = params[:username]
    user_type = params[:user_type]
    user = nil
    if user_type == 'console'
      user = User.find_by(:username => username)
      if user != nil && user.user_type == 'webapp'
        user = nil
      end
    else
      user = User.find_by(:username => username,:user_type=>user_type)
    end
    if user == nil
      render json: { success:false , errMsg:"登录失败" }, status: 200
    else
      render json: { success:true}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit(
        :username,
        :show_name,
        :cellphone,
        :avatar,
        :email,
        :password,
        :password_confirmation)
  end

end
