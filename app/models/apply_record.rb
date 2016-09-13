class ApplyRecord < ActiveRecord::Base
  def method
  end

  # 按创建时间查找
  scope :filter_time_from, ->(created_at){
    where("created_at >= ?", created_at) if created_at.present?
  }

  scope :filter_time_to, ->(created_at){
    where("created_at < ?", created_at) if created_at.present?
  }

  # 是否应聘过？是：true;否：false
  def self.is_applied(uid, job_id)
    ! ApplyRecord.where(user_id: uid, job_id: job_id).blank?
  end

  # 更新user时更新apply_record的冗余信息
  def self.update_apply_record user
    apply_records = ApplyRecord.where(user_id: user.id)
    if !apply_records.blank?
      apply_records.each do |a|
        a.sex = user.sex
        a.age = ((Time.now - user.birthday)/1.year).to_i if user.birthday.present?
        a.highest_degree = user.highest_degree
        a.show_name = user.show_name
        a.start_work_at = user.start_work_at
        a.save!
      end
    end
    return apply_records
  end

  # 更新job时更新apply_record的冗余信息
  def self.job_update_record job
    apply_records = ApplyRecord.where(job_id: job.id)
    if !apply_records.blank?
      apply_records.each do |a|
        hospital = Hospital.find a.hospital_id
        a.job_name = job.name
        a.job_type = job.job_type
        a.job_location = job.region
        a.salary_range = job.salary_range
        a.hospital_region = hospital.region
        a.save!
      end
    end
    return apply_records
  end
end
