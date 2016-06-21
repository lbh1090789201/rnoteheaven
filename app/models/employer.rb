class Employer < ActiveRecord::Base
  # 按user_id 返回医院
  scope :get_hospital, -> (uid) {
    hid = Employer.find_by(user_id: uid).hospital_id
    Hospital.find hid
  }

  # 获得 VIP 状态
  def self.get_status uid
    ee = Employer.find_by user_id: uid

    vip_status = {}
    vip_status[:may_receive] = ee[:may_receive] > ee[:has_receive]
    vip_status[:may_release] = ee[:may_release] > ee[:has_release]
    vip_status[:may_set_top] = ee[:may_set_top] > ee[:has_set_top]
    vip_status[:may_view] = ee[:may_view] > ee[:has_view]

    return vip_status.as_json
  end

end
