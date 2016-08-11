class Hospital < ActiveRecord::Base
  belongs_to :employer
  has_many :resume_views
  has_many :jobs, dependent: :destroy
  has_many :fair_hospitals, dependent: :destroy
  has_many :resume_viewers, dependent: :destroy

  validates :introduction, length: { in: 4..800 }

  # 按城市搜索
  scope :filter_location, -> (region) {
    filter = "region like '%" + region + "%'" if region.present?
    where(filter) if region.present?
  }

  #按医院
  scope :filter_hospital_name, -> (name) {
    filter = "name LIKE '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

  #按负责人
  scope :filter_contact_person, -> (name) {
    filter = "contact_person LIKE '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

  #按负责人
  scope :filter_contact_number, -> (number) {
    filter = "contact_number LIKE '%" + number + "%'" if number.present?
    where(filter) if number.present?
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
    where("created_at <= ?", created_at.to_date + 1.day) if created_at.present?
  }

  #admin hospital　
  def self.get_info hospitals
    @hospitals = []
    hospitals.each do |h|
      employer = Employer.find_by(hospital_id: h.id)
      if employer.present?
        plan = Plan.find employer.plan_id
        status = employer.user_id ? '已激活' : '未激活'

        o = {
          id: h.id,
          name: h.name,
          property: h.property,
          scale: h.scale,
          industry: h.industry,
          region: h.region,
          location: h.location,
          introduction: h.introduction,
          contact_person: h.contact_person,
          contact_number: h.contact_number,
          lng: h.lng,
          lat: h.lat,
          vip_name: plan.name,
          may_release: plan.may_release,
          may_set_top: plan.may_set_top,
          may_receive: plan.may_receive,
          may_view: plan.may_receive,
          may_join_fairs: plan.may_join_fairs,
          vip_id: plan.id,
          status: status,
          created_at: h.created_at
        }
        @hospitals.push(o)
      else
        @hospitals.push(h)
      end

    end
    return @hospitals
  end
end
