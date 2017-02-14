class Gallery < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

end
