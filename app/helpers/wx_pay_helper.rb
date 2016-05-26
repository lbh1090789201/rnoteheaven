require 'json'
require 'socket'
require 'digest/md5'
require 'savon'

module WxPayHelper

  #生成随机数
  def generate_code(count)
    array = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

    code = ''
    (1..count).each do
      code += array[rand(62)]
    end
    code
  end

  #生成随机数
  def generate_number_code(count)
    array = ['0','1','2','3','4','5','6','7','8','9']
    code = ''
    (1..count).each do
      code += array[rand(10)]
    end
    code
  end

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  #统一下单 money
  def pay_wx(user_id, money, notify_url)
    if Rails.env != "production"
      return 'success'
    end

    user = User.find(user_id)
    out_trade_no = (Time.now.to_i).to_s + generate_number_code(10)
    local_ip = local_ip()
    notify_url = notify_url
    params = {
        body: 'hellobaby秀色可餐账户充值',
        out_trade_no: out_trade_no, #商户单号
        total_fee: 1, #订单总金额，单位为分，详见支付金额
        spbill_create_ip: local_ip, #终端IP
        notify_url: notify_url,
        trade_type: 'JSAPI', # could be "JSAPI", "NATIVE" or "APP",
        openid: user.wechat_openid
    }
    logger.info '------params---------:'+params.to_json.to_s
    r = WxPay::Service.invoke_unifiedorder params
    logger.info '------r---------:'+r.to_s
    #{
    # "return_code"=>"SUCCESS",
    # "return_msg"=>"OK",
    # "appid"=>"wx3e615f91a151f3e1",
    # "mch_id"=>"1283250901",
    # "nonce_str"=>"iMfEOUYSXIsAmrjK",
    # "sign"=>"C4CB6028C5265213055AB41D65C5FA74",
    # "result_code"=>"SUCCESS",
    # "prepay_id"=>"wx20160329192946c2060e1bac0165705835",
    # "trade_type"=>"JSAPI"}
    if r['return_code'] == 'SUCCESS'
      rrr = search_pay_wx_order(out_trade_no)
    end
    result = {
        out_trade_no: out_trade_no,
        response: r
    }
    result
  end

  #订单查询
  def search_pay_wx_order(out_trade_no)
    p = {
        out_trade_no:out_trade_no
    }
    rrr = WxPay::Service::order_query p
    logger.info '------rrr---------:'+rrr.to_s
  end

end