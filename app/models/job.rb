class Job < ActiveRecord::Base
  belongs_to :hospital

  # 按城市搜索
  scope :filter_location, -> (location) {
    filter = "location like '%" + location + "%'" if location.present?
    where(filter) if location.present?
  }

  # 按职位
  scope :filter_job_name, -> (name) {
    filter = "name like '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

end
