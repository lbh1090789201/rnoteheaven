class Hospital < ActiveRecord::Base
  has_many :resume_views

  validates :introduction, length: { in: 4..45 }

  # 按城市搜索
  scope :filter_location, -> (location) {
    filter = "location like '%" + location + "%'" if location.present?
    where(filter) if location.present?
  }

  #按医院
  scope :filter_hospital_name, -> (name) {
    filter = "name like '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }
end
