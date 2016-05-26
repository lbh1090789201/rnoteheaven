module ValidationCodesHelper

  # 获取验证码
  def create_vcode(validation_code_params)
    phone = validation_code_params[:cellphone]
    # 第三方登录
    # if validation_code_params[:request_type] == "third_party"
    #   decrypt_data = decrypt_ecb(phone)
    #   decrypt_cellphone = JSON.parse decrypt_data
    #   login_time = decrypt_cellphone["time"]
    #   five_minutes_advance = Time.now - 5.minutes
    #   five_minutes_later = Time.now + 5.minutes
    #   unless login_time || five_minutes_advance > Time.parse(login_time) || five_minutes_later < Time.parse(login_time)
    #     render :json => { success: false, errors: ['错误数据'] },
    #            :status => 403
    #     return
    #   end
    #   unless decrypt_cellphone["username"]
    #     render json: {
    #         success: false,
    #         errors: ["wrong format!"]
    #     }, status: 403
    #     return
    #   end
    #   phone = decrypt_cellphone["username"].downcase
    #   show_name = decrypt_cellphone["show_name"]
    # end

    # 生成验证码
    vc = ValidationCode.generate_vcode phone

    unless vc
      render :json => { success: false, errors: ['请勿频繁申请短信验证码'] },
             :status => 403
      return
    else
      vc.save
      # if validation_code_params[:request_type].to_s == "third_party"
      #   data = {:vcode => vc.vcode,
      #           :password => Devise.friendly_token.first(8)}
      #   u = User.find_by(cellphone: phone)
      #   if u
      #     u.update(password: data[:password])
      #     data[:vcode] = "LOGO"
      #   else
      #     #微信的Token经常变化
      #     #v = User.find_by(show_name: show_name) if show_name
      #     #if v
      #     #  v.update(cellphone: phone, username: phone, password: data[:password])
      #     #  data[:vcode] = "LOGO"
      #     #end
      #   end
      #
      #   render :json => { success: true, info: '第三方登录第一步成功', vcode: encrypt_ecb(data.to_json.to_s)},
      #          :status => 200
      #   return

      # send_sms(phone,"【消费金融】尊敬的用户，您好！您在享投时代申请的注册码是#{vc.vcode}，工作人员不会向您索取。")
      if sms(phone,"【hellobaby】尊敬的用户，您好！您在hellobaby申请的注册码是#{vc.vcode}，工作人员不会向您索取。")
        render :json => { success: true, info: '已经发送短信'},
               :status => 200
      else
        render json:{
                   success: false,
                   errors: ['短信网关错误']
               },status: 401
      end
    end
  end

  def sms(telphone, content)
    params = {
        userid: '385',
        account: 'luyun',
        password: '666666',
        mobile: telphone,
        content: content,
        action:'send',
    }
    url = 'http://120.24.241.49/sms.aspx'
    #   Foo.post('http://foo.com/resources', query: {bar: 'baz'})

    response = HTTParty.get(url, query: params)
    rep = response['returnsms']
    puts rep
    if rep['returnstatus'] == 'Faild'
      return false
    end
    return true
  end

end
