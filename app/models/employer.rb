class Employer < ActiveRecord::Base
  # 按user_id 返回医院
  scope :get_hospital, -> (uid) {
    hid = Employer.find_by(user_id: uid).hospital_id
    Hospital.find hid
  }

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

end
