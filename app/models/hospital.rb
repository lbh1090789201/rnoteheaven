class Hospital < ActiveRecord::Base
  has_many :resume_views
  has_many :jobs

  validates :introduction, length: { in: 4..45 }

  # 按城市搜索
  scope :filter_location, -> (location) {
    filter = "location like '%" + location + "%'" if location.present?
    where(filter) if location.present?
  }

  #按医院
  scope :filter_hospital_name, -> (name) {
    filter = "name LIKE '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

  #按负责人
  #TODO 待写测试
  scope :filter_contact_person, -> (name) {
    filter = "contact_person LIKE '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

  #按医院类别查找
  scope :filter_by_property, ->(property) {
    where("property like '%" + property + "%'") if property.present?
  }

  # 按医院创建时间
  scope :filter_create_before, ->(created_at) {
    where("created_at >= ?", created_at) if created_at.present?
  }

  # 按医院创建时间
  scope :filter_create_after, ->(created_at) {
    where("created_at <= ?", created_at) if created_at.present?
  }
end
