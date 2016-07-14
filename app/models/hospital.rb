class Hospital < ActiveRecord::Base
  belongs_to :employer
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

  #admin hospital　待写测试
  def self.get_info hospitals
    @hospitals = []
    hospitals.each do |h|
      employer = Employer.find_by(hospital_id: h.id)
      plan = Plan.find employer.plan_id

      o = {
        id: h.id,
        hospital_name: h.name,
        property: h.property,
        scale: h.scale,
        industry: h.industry,
        region: h.region,
        location: h.location,
        introduction: h.introduction,
        vip_name: plan.name,
        may_release: plan.may_release,
        may_set_top: plan.may_set_top,
        may_receive: plan.may_receive,
        may_view: plan.may_receive,
        may_join_fairs: plan.may_join_fairs,
      }
      @hospitals.push(o)
    end
    return @hospitals
  end
end
