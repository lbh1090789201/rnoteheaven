class Job < ActiveRecord::Base
  belongs_to :hospital

  # 按城市搜索
  scope :location, -> (location) {
    where(:location => location)
  }

  # 按职位
  scope :position_name, -> (name) {
    where(:name => name)
  }

  #按医院
  scope :hospital_name, -> (name) {
    where(:name => name)
  }
end
