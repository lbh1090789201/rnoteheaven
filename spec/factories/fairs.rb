FactoryGirl.define do
  factory :fair do
      name '高级护士专场' #专场名称
      creator '创建者' #创建者
      banner Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG'))) #专场图片
      intro '我是专场介绍～～～～～～～～～～～' #专场介绍
      status 'processing' #专场状态: processing 进行中， pause 暂停
      begain_at Time.now #开始时间
      end_at Time.now + 10.days #结束时间  end
  end
end
