class UsersController < ApplicationController
  #before_filter :authenticate_user_from_token!, except: [:forgot_password]
  #bafore_filer代表需要加载请求头　except代表除开它指定的请求外其它都需要
  #bafore_filer注释后就整个不需要加载请求头
  # before_filter :authenticate_user!, except: [:forgot_password]
  before_action do
    current_user ? @user_id = current_user.id : @user_id = ""
    authenticate_user!
    @title = "个人中心"
  end

  def index

  end
  def show
    # @user = User.friendly.find(params[:id])
    @user = {}
    user = User.find current_user.id
    @user["user"] = user.as_json
    @user["avatar"] = user.avatar_url ? user.avatar_url : "avator.png"
    notes = Note.where(user_id: user.id)
    @user["art_amount"] = notes.size
    @user["recom_amount"] = Recommend.where(user_id: user.id).size
    @user["com_amount"] = Comment.where(user_id: user.id).size
    @user["favorite_amount"] = FavoriteArticle.where(user_id: user.id).size
    # 被推荐，被收藏，被评论
    brecom_amount = 0
    bfavorite_amount = 0
    bcom_amount = 0
    notes.each do |n|
      recommend = Recommend.where(note_id: n.id)
      brecom_amount += recommend.size
      favorite_article = FavoriteArticle.where(note_id: n.id)
      bfavorite_amount += favorite_article.size
      comment = Comment.where(note_id: n.id)
      bcom_amount += comment.size
    end
    @user["brecom_amount"] = brecom_amount
    @user["bfavorite_amount"] = bfavorite_amount
    @user["bcom_amount"] = bcom_amount

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
    # @user = User.friendly.find(params[:id])
    user = User.find current_user.id
    @user = user.as_json
    @avatar = user.avatar_url ? user.avatar_url : "avator.png"
    p @user
    p @avatar
  end

  def update
    # @user = User.friendly.find(params[:id])
    #
    # if @user.update(user_params)
    #   redirect_to @user
    # else
    #   render 'edit'
    # end
    if params[:avatar]
      user = User.find current_user.id
      user.avatar = params[:avatar]
      if user.save!
        render json: {
          success: true,
          info: "更改头像成功！",
          avatar: user.avatar_url
        }, status: 200
      else
        render json: {
          success: false,
          info: "更改头像失败！",
        }, status: 403
      end
    else
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
