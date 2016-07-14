class Plan < ActiveRecord::Base
  belongs_to :employer

  #按套餐名称查找
  scope :filter_by_name, ->(name) {
    where("name LIKE ?", "%#{name}%") if name.present?
  }

  #按状态查找
  scope :filter_by_status, ->(status) {
    where(status: status) if status.present?
  }
end
