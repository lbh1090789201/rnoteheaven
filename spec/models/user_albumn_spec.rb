require 'rails_helper'

# RSpec.describe UserAlbumn, type: :model do
#   it "test albumn" do
#     user = create(:user)
#     albumn = user.user_albumns.new
#     albumn.image = "MyString"
#     raise "failed" unless user.user_albumns
#     # raise "failed create albumn" if user.user_albumns.first.image != "default.png"
#   end
#
#   it "test albumn2" do
#     user = create(:user)
#     albumn = user.user_albumns.new
#     albumn.image = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG')))
#     raise "failed" unless user.user_albumns
#     raise "failed create albumn" if user.user_albumns.first.image_url.index("testfile.JPG") == -1
#   end
#
#
# RSpec.describe UserAlbumn, type: :model do
# end
RSpec.describe UserAlbumn, type: :model do
  it "is valid to create UserAlbumn" do
    # user_albumn = build(:user_albumn)
    # expect(user_albumn).to be_valid

  end
end
