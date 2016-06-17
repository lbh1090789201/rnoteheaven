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

  # 获得求职者信息
  def self.get_seekers jid
    job = Job.select(:id, :name, :hospital_id).find(jid).as_json
    apply_records = ApplyRecord.where(hospital_id: job["hospital_id"])
    has_new = apply_records.where(view_at: nil).blank? ? false : true
    seekers = []

    apply_records.each do |f|
      resume_info = Resume.info f.user_id
      resume_info[:apply_at] = f.apply_at
      seekers.push resume_info
    end

    job[:hospital_region] = Hospital.find_by(job[:hospital_id]).region
    job[:has_new] = has_new
    job[:seekers] = seekers

    return job
  end

end
