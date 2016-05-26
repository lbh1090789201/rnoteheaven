class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]



  def home
    redirect_to $client.authorize_url('http://hb.yundaioa.com/show',"snsapi_userinfo")

  end

  def show
    # 回调后，获取code请求token或者openid:
    sns_info = $client.get_oauth_access_token(params[:code])
    # 再调用以下API，拉取用户信息：
    logger.info sns_info.result
    @user_info = $client.get_oauth_userinfo(sns_info.result["openid"], sns_info.result["access_token"])
    # 展示用户信息
    logger.info @user_info.full_message


  end

  def show_news

  end
  def inside
  end
  
  
end
