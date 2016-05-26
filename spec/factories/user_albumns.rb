FactoryGirl.define do
  factory :user_albumn do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG')))
  end

end
