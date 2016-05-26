require 'digest/sha1'
module WeixinShareHelper

  #生成随机数
  def get_generate_number_code(count)
    array = ['0','1','2','3','4','5','6','7','8','9']
    code = ''
    (1..count).each do
      code += array[rand(10)]
    end
    code
  end

  def get_jsapi_ticket
    if $ticket == nil || $ticket_time + 6600 > Time.now.to_i
      access_token = get_access_token()
      url = 'https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token='+ access_token +'&type=jsapi' # get请求
      response = HTTParty.get(url)
      logger.info '------response---------:'+response.to_s
      # data = JSON.parse(response)
      $ticket = response['ticket']

      $ticket_time = Time.now.to_i
    end
    $ticket
  end

  def get_access_token
    if $access_token == nil || $access_token_time + 6600 > Time.now.to_i
      url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid='+$WX_APPID+'&secret=' + $WX_APPSECRET # get请求
      response = HTTParty.get(url)
      logger.info '------response---------:'+response.to_s
      # data = JSON.parse(response)
      $access_token =response['access_token']
      $access_token_time = Time.now.to_i
    end
    $access_token
  end

  def get_share_sign(url)
    jsapi_ticket = get_jsapi_ticket
    nonce_str = get_generate_number_code(25)
    timestamp = Time.now.to_i.to_s

    string1 = 'jsapi_ticket='+jsapi_ticket+'&noncestr='+nonce_str+'&timestamp='+timestamp+'&url='+url
    logger.info '------string1---------:'+string1
    sign = Digest::SHA1.hexdigest('jsapi_ticket='+jsapi_ticket+'&noncestr='+nonce_str+'&timestamp='+timestamp+'&url='+url)

    url_index = url.index('/', 9) - 1
    website_domains = url[0..url_index]
    data = {
        appId: $WX_APPID, # 必填，公众号的唯一标识
        timestamp: timestamp, # 必填，生成签名的时间戳
        nonceStr: nonce_str, # 必填，生成签名的随机串
        signature: sign,# 必填，签名
        website_domains: website_domains
    }
    logger.info '------data---------:'+data.to_json.to_s
    data
  end

end