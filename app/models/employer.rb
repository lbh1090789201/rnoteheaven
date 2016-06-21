class Employer < ActiveRecord::Base
  # 按user_id 返回医院
  scope :get_hospital, -> (uid) {
    hid = Employer.find_by(user_id: uid).hospital_id
    Hospital.find hid
  }

end
