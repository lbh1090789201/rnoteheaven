FactoryGirl.define do
  factory :user, :class => 'User' do
    username "test"
    sex "男"
    email "public@roadclouding.com"
    cellphone "13076016866"
    password "12345678"
    show_name "3654"
    avatar Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG')))
    start_work_at 2010
    location "武汉"
    seeking_job "正在求职"
    highest_degree "本科"
    position "高级护士"
    birthday Time.now - 365.days
    user_type "copper"
    user_number 2
  end

  factory :user2, :class => 'User' do
    show_name "zahng"
    username "username"
    email "644381492@qq.com"
    cellphone "13944445555"
    password "123465"
    birthday Time.now - 1365.days
  end
  factory :myuser do
    show_name "zahng"
    username "username"
    email  { Faker::Internet.email }
    cellphone "13944445555"
    password "123465"
  end
end

#cellphone",
#avatar",
#show_name",
#provider",
#uid",
#tokens",
#username",
#email",
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
#sex",
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
#merchant_id",
