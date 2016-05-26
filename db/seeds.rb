# Generated with RailsBricks
# Initial seed file to use with Devise User Model

User.create!(
    username: "notactiveadmin",
    email: "admin@example.com",
    password: "password",
    show_name: "张三",
    cellphone: "13912345678",
    #avatar",
    #provider",
    #tokens",
    #encrypted_password",
    #locked",
    #slug",
    #reset_password_token",
    #reset_password_sent_at"
    #remember_created_at"
    #sign_in_count",
    #current_sign_in_at"
    #last_sign_in_at"
    #current_sign_in_ip",
    #last_sign_in_ip",
    #confirmation_token",
    #confirmed_at"
    #confirmation_sent_at"
    #unconfirmed_email",
    #main_video",
    sex: "男",
    #user_number",
    #wechat_openid",
    #vcode",
    #update_vcode_time",
    #transaction_password",
    #longitude",
    #latitude",
    #balance",
    #total_consumption",
    #user_type",
    #is_top",
    merchant_id: '111'
)


# Test User :tw
# i = 1
# while i < 5 do
#     User.create! ({
#     :longitude => '我是User经纬度',
#     :password => 111222,
#     :username => rand(66666).to_s,
#     :email => rand(9999999).to_s + '@qq.com',
#     :cellphone => '13068649526',
#     :created_at => '10/04/2015'.to_date,
#     :confirmed_at => 'tw',
#     :avatar => 'tw',
#     :user_number => 114,
#     :show_name => '鬼五十七',
#     :user_type => 'merchant',
#     :merchant_id => i
#     })
#   i += 1
# end

# Test UserInfo :tw
# i = 1
# while i < 5 do
#     UserInfo.create! ({
#     :user_id => i,
#     :main_picture => 'kkk',
#     :age => 'rand(66)',
#     :height => rand(999),
#     :mood => '13068649526',
#     :lover => '篮球',
#     :job => 'tw',
#     :favorite_place => 'tw',
#     :favorite_food => '海鲜',
#     :verification_status => '审核通过',
#     :unpass_reason => '照片不合法'
#     })
#   i += 1
# end
