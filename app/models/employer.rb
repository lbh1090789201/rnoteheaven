class Employer < ActiveRecord::Base
  # 按user_id 返回医院
  scope :get_hospital, -> (uid) {
    hid = Employer.find_by(user_id: uid).hospital_id
    Hospital.find hid
  }

  has_one :hospital
  has_one :plan

  # 获得 VIP 状态
  def self.get_status uid
    ee = Employer.find_by user_id: uid
    ee[:has_receive] = ApplyRecord.where(hospital_id: ee.hospital_id).length

    vip_status = {}
    vip_status[:may_receive] = ee[:may_receive] > ee[:has_receive]
    vip_status[:may_release] = ee[:may_release] > ee[:has_release]
    vip_status[:may_set_top] = ee[:may_set_top] > ee[:has_set_top]
    vip_status[:may_view] = ee[:may_view] > ee[:has_view]

    return vip_status.as_json
  end

  # 校准 VIP 值
  def self.check_vip uid
    ee = Employer.find_by user_id: uid
    ee[:has_receive] = ApplyRecord.where(hospital_id: ee.hospital_id).length
    ee[:has_release] = Job.where(hospital_id: ee.hospital_id).where.not(status: ["saved", "fail"]).length
    ee[:has_set_top] = Job.where(hospital_id: ee.hospital_id, is_top: true).where.not(status: ["saved", "fail"]).length
    ee[:has_view] = ResumeViewer.where(hospital_id: ee.hospital_id).length

    ee.save
    return ee
  end

  # 改变 VIP 状态
  def self.vip_count uid, prop
    ee = Employer.find_by user_id: uid
    ee[:"#{prop}"] += 1

    if ee.save
      return true
    else
      return false
    end
  end

  # 设置 VIP 等级
  def self.set_vip uid, level
    if level == 1
      employer = Employer.find_by user_id: uid
      employer.may_receive = 200
      employer.may_release = 10
      employer.may_set_top = 10
      employer.may_view = 10

      if employer.save
        return {json: {
          success: true,
          info: "设置vip成功！"
        }, status: 200}
      else
        return {json: {
          success: false,
          info: "设置vip失败"
        }, status: 403}
      end
    else
        return {json: {
          success: false,
          info: "无此vip等级"
        }, status: 403}
    end
  end

  # 根据 plan 设定 vip 限额
  def self.set_plan uid, plan_id
    employer = Employer.find_by user_id: uid
    plan = Plan.find_by  id: plan_id

    if plan.nil?
      plan = Plan.first_or_create!(
        name: 'vip0',
        may_receive: 10,
        may_release: 10,
        may_set_top: 1,
        may_view: 10,
        may_join_fairs: 1
      )
    end

    employer.plan_id = plan.id
    employer.may_receive = plan.may_receive
    employer.may_release = plan.may_release
    employer.may_set_top = plan.may_set_top
    employer.may_view = plan.may_view
    employer.may_join_fairs = plan.may_join_fairs

    employer.save
    return employer
  end

  # 根据 employer 设定 vip 限额
  def self.employer_plan employer, plan_id
    plan = Plan.find_by  id: plan_id

    if plan.nil?
      plan = Plan.first_or_create!(
        name: 'vip0',
        may_receive: 10,
        may_release: 10,
        may_set_top: 1,
        may_view: 10,
        may_join_fairs: 1
      )
    end

    employer.plan_id = plan.id
    employer.may_receive = plan.may_receive
    employer.may_release = plan.may_release
    employer.may_set_top = plan.may_set_top
    employer.may_view = plan.may_view
    employer.may_join_fairs = plan.may_join_fairs

    employer.save
    return employer
  end

  # 按 hospital 医院名
  scope :filter_hospital_name, ->(name) {
    includes(:hospital).where{(name =~  "%#{name}%")} if name.present?
  }

end
