module Webapp::ApplyRecordsHelper
  # 获取数据
  def get_apply_records(user_id)
    ars = ApplyRecord.where(user_id: user_id)
    apply_records = []
    ars.each do |ar|
      job = Job.find_by_id ar.job_id
      hospital = Hospital.find job.hospital_id #bh
      a = {
        id: ar.id,
        job_name: job.name,
        salary_range: job.salary_range,
        location: job.location,
        resume_status: ar.resume_status,
        apply_at: ar.apply_at.strftime("%y-%m-%d"),#bh
        hospital_name: hospital.name #bh
      }
      apply_records.push(a)
    end
    apply_records
  end

end
