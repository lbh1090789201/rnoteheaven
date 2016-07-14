class FairHospital < ActiveRecord::Base
  mount_uploader :banner, AvatarUploader

  # 获取参与专场的医院的统计信息
  def self.get_info fair_hospitals
    res = []

    fair_hospitals.each do |f|
      fair_hospital = FairHospital.statistic f

      res.push fair_hospital
    end

    return res
  end

  def self.statistic f
    jobs = Job.where hospital_id: f.hospital_id
    resumes = ApplyRecord.where from: f.fair_id, hospital_id: f.hospital_id

    fair_hospital = f.as_json
    fair_hospital["jobs_count"] = jobs.length
    fair_hospital["resumes_count"] = resumes.length

    return fair_hospital
  end
end
