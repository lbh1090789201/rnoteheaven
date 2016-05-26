class LoadController < ApplicationController

  def home
    # 回调后，获取code请求token或者openid:
    if params[:code]
      sns_info = $client.get_oauth_access_token(params[:code])
      # 再调用以下API，拉取用户信息：
      logger.info sns_info.result
      $access_token = sns_info.result["access_token"]
      $access_token_time = Time.now.to_i
      user_info = $client.get_oauth_userinfo(sns_info.result["openid"], sns_info.result["access_token"])
      # 展示用户信息
      # logger.info user_info.full_message
      # logger.info '--------------user_info' + user_info.to_json.to_s
      openid = user_info.result["openid"]
      # logger.info '--------------openid' + openid.to_s
      sex = user_info.result["sex"]
      if sex == 2 #微信2为女
        sex = 0#我们０为女
      else
        sex = 1
      end
      show_name = user_info.result["nickname"]
      avatar_url = user_info.result["headimgurl"]
      unionid = user_info.result["unionid"]
      if User.find_by(wechat_openid: openid)
        #登录
        redirect_to '/users/sign_in?openid='+ openid
        return
      else
        #注册先验证注册码再注册
        # logger.info  '/users/sign_up?openid='+openid+'&sex='+sex.to_s+'&show_name='+show_name+'&avatar_url=' +avatar_url +'&unionid='+unionid
        logger.info  '/users/code?openid='+openid+'&sex='+sex.to_s+'&show_name='+show_name+'&avatar_url=' +avatar_url +'&unionid='+unionid
        redirect_to '/users/code?openid='+openid+'&sex='+sex.to_s+'&show_name='+show_name+'&avatar_url=' +avatar_url +'&unionid='+unionid
        return
      end
    elsif params[:test]
      redirect_to '/users/sign_in?openid='+'asc2312qass'
      return
    else
      redirect_to '/webapp/restaurants'
    end
  end

  def index
    redirect_to $client.authorize_url('http://hb.yundaioa.com/home',"snsapi_userinfo")
  end

  def toast
    @code = params[:code]
  end

  def login
    redirect_to '/users/sign_in?type=console'
  end
end
