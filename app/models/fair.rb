class Fair < ActiveRecord::Base
  mount_uploader :banner, AvatarUploader

  has_many :fair_hospitals, dependent: :destroy

  scope :filter_begain_at, -> (begain_at) {
     where('begain_at > ?', begain_at) if begain_at.present?
   }

  scope :filter_end_at, -> (end_at) {
    where('begain_at < ?', end_at.to_date + 1.day) if end_at.present?
  }

  scope :filter_by_name, -> (name) {
    where('name LIKE ?', "%#{name}%") if name.present?
  }

  scope :filter_by_status, -> (status){
    where(status: status) if status.present?
  }

# 所有专场获取统计数据
  def self.get_info fairs
    res = []

    fairs.each do |f|
      fair = Fair.fair_statistic f
      res.push fair
    end

    return res
  end

  # 根据单独一场统计数据
  def self.fair_statistic f
    fair_hospitals = FairHospital.where fair_id: f.id

    hospital_ids = fair_hospitals.uniq.pluck(:hospital_id)
    jobs = Job.where hospital_id: hospital_ids
    resumes_count = ApplyRecord.where from: f.id

    fair = f.as_json
    fair["hospitals_count"] = fair_hospitals.length
    fair["jobs_count"] = jobs.length
    fair["resumes_count"] = resumes_count.length

    return fair
  end

  # 专场结束后设定 参加机构，发布职位数，收到简历数
  # TODO 待写测试
  def self.set_end fair
    # fair = Fair.find fair.id
    fair_info = Fair.fair_statistic fair
    fair.hospitals_count = fair_info["hospitals_count"]
    fair.jobs_count = fair_info["jobs_count"]
    fair.resumes_count = fair_info["resumes_count"]
    fair.status = 'end'

    fair.save
    return fair
  end

  # 检验专场是否过期 fairs
  # TODO 待写测试
  def self.is_end fairs
    res = []

    fairs.each do |f|
      if f.end_at < Time.now
        f = Fair.set_end f
      else
        res.push f
      end
    end

    return res
  end

end
