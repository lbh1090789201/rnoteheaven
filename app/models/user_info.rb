class UserInfo < ActiveRecord::Base
  belongs_to :user

  mount_uploader :main_picture, AlbumnUploader
  # t.string :main_picture #主图
  # t.string :video #视频
  # t.string :age #年龄
  # t.float :height #身高
  # t.text :mood #心情
  # t.text :lover #欣赏的异性
  # t.string :job #职业
  # t.string :favorite_place #常出没地
  # t.string :favorite_food #喜爱美食
end
