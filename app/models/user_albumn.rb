class UserAlbumn < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, AlbumnUploader
# 相册
#   t.string :image
end
