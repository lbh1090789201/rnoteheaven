class Job < ActiveRecord::Base

  # 默认按 VIP 优先排序
  default_scope { order('is_top DESC') }

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

  # 按发布时间
  scope :filter_release_before, -> (time) {
    where('release_at < ?', time) if time.present?
  }

  # 按发布时间
  scope :filter_release_after, -> (time) {
    where('release_at > ?', time)
  }

  # 按工作类型
  scope :filter_job_type, -> (type){
    where(job_type: "#{type}")
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
      resume_info[:apply_record_id] = f.id
      resume_info[:edu_num] = Job.get_edu_num f.highest_degree
      resume_info[:exp_num] = Job.get_exp_num f.start_work_at
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

  # 获得剩余更新时间
  def self.left_refresh_time t
    if Time.now.to_i < (t + 7.days).to_i
      return ((t + 7.days + 1.hour - Time.now)/1.day).to_i
    else
      return -1
    end
  end

  # 获得求职者 最高学历 数字代号
  def self.get_edu_num edu
    case edu
    when "大专以下"
      return 0
    when "大专"
      return 2
    when "本科"
      return 4
    when "硕士"
      return 6
    when "博士"
      return 8
    when "博士后"
      return 10
    else
      return 0
    end
  end

  # 获得求职者 工作年限 数字代号
  def self.get_exp_num exp
    case exp
    when "在读学生"
      return 0
    when "应届毕业生"
      return 2
    when "1年"
      return 4
    when "２年"
      return 6
    when "3-4年"
      return 8
    when "5-7年"
      return 10
    when "8-9年"
      return 12
    when "10年以上"
      return 14
    else
      return 0
    end
  end

end
