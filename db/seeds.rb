# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# User.create!(
    # username: "test",
    # show_name: "test",
    # password: "123456",
    # email: "admin@example.com",
    # cellphone: "13888888888",
    # sex: "男"
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
# )


Test ApplyRecord :tw
i = 1
while i < 3 do
    ApplyRecord.create! ({
      resume_id: 1,
      job_id: 1,
      apply_at: "2016-5-26",
      resume_status: "筛选",
      recieve_at: "2016-5-27",
    })
  i += 1
end

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
