FactoryGirl.define do
  factory :fair_hospital do
    hospital_id 1
    fair_id 1
    user_id 1 #操作者ID

    contact_person "张三" #联系人
    contact_number '13888888888' #手机号码
    intro "我是参与专场的介绍" #介绍
    banner Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG'))) #医院图片
    status 'on' #状态 on pause quit
    operator '李四管理' #操作人  end
  end
end
