class Job < ActiveRecord::Base

  # 按Hospital id
  scope :filter_hospital_id, -> (hid) {
    filter = "hospital_id = " + hid if hid.present?
    where(filter) if hid.present?
  }

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

  # 按Hospital Name
  scope :filter_hospital_name, -> (name) {
    if name.present?
      hospitals = Hospital.filter_hospital_name(name).limit(20)
      if hospitals.size > 0
        hids = ""
        hospitals.each do |h|
          hids = hids + h.id.to_s + ","
        end
        s = hids[0..(hids.size-2)]
        filter = "hospital_id in (" + s + ")"
        # puts where(filter).to_sql.to_s
        return where(filter)
      end
      return where("id = 0")
    end
  }

end
