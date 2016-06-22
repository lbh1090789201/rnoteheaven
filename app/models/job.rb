class Job < ActiveRecord::Base

  # 按Hospital id
  scope :filter_hospital_id, -> (hid) {
    filter = "hospital_id = " + hid if hid.present?
    where(filter) if hid.present?
  }

  # 按城市搜索
  scope :filter_location, -> (location) {
    filter = "region like '%" + location + "%'" if location.present?
    where(filter) if location.present?
  }

  # 按职位
  scope :filter_job_name, -> (name) {
    filter = "name like '%" + name + "%'" if name.present?
    where(filter) if name.present?
  }

  # 按状态
  scope :filter_job_status, -> (status) {
    where(status: "#{status}") if status.present?
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
    apply_records = ApplyRecord.where(job_id: job["id"])
    has_new = apply_records.where(view_at: nil).blank? ? false : true
    seekers = []

    apply_records.each do |f|
      resume_info = Resume.info f.user_id
      resume_info[:apply_at] = f.apply_at
      resume_info[:from] = f.from
      resume_info[:resume_status] = f.resume_status
      seekers.push resume_info
    end

    job[:hospital_region] = Hospital.find_by(job[:hospital_id]).region
    job[:has_new] = has_new
    job[:seekers] = seekers

    return job.as_json
  end

  # 获得剩余发布时间
  def self.time_left jid
    job = Job.find jid

    if job.end_at > Time.now
      return ((job.end_at + 1.hour - Time.now)/1.day).to_i
    else
      return 0
    end
  end

  # 获得工作各种状态
  # def self.get_state jid
  #   job = Job.find jid
  #   state = {}
  #
  #   state[:left_time] = left_refresh_time job.refresh_at
  #
  # end

  # 获得剩余更新时间
  def self.left_refresh_time t
    if Time.now.to_i < (t + 7.days).to_i
      return ((t + 7.days + 1.hour - Time.now)/1.day).to_i
    else
      return -1
    end
  end

end
