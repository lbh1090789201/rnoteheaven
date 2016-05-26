class Webapp::RegistersController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  #信息确认页面
  def infoConfirm

  end

  #完善视频页面
  def videoIndex
      @user_id = current_user.id
  end

  def edit
  @user_id = current_user.id
  @user = User.find(@user_id)
  puts '@user_id'+@user_id.to_json.to_s
  @user_albumns = UserAlbumn.where(user_id: @user_id)
  end

  def update
    @user_id = current_user.id
    user = User.find_by(id: @user_id)
    user_albumn = UserAlbumn.find_by(user_id: @user_id)
    puts 'user_albumn[[[[[[[[[[[[[['+user_albumn.to_json.to_s
    if params[:register]
      params_register = params[:register]
      if params_register[:main_video]
        user.main_video = params_register[:main_video]
        user.save
        redirect_to edit_webapp_register_path(title:'picture')
      end
      if params_register[:picture]
        user_albumn.image = params_register[:picture]
        user_albumn.save
        return
      end
    end
  end

  #设置主图
  def setMainPicture
    if params[:picId]
      id = params[:picId]
      user_albumn = UserAlbumn.find(id)
      userInfo = UserInfo.find_by(user_id: params[:register_id])
      userInfo.main_picture = user_albumn.image
      if userInfo.save
        render json: {
                   result: true
               },status: 200
      end
    end
  end

  #设置头像
  def setAvatar
    if params[:picId]
      id = params[:picId]
      user_albumn = UserAlbumn.find(id)
      user = User.find_by(id: params[:register_id])
      user.avatar = user_albumn.image
      if user.save
        render json: {
                   result: true
               },status: 200
      end
    end
  end
end
