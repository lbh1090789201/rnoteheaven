module Webapp::ApplyRecordsHelper
  # 获取数据
  def get_apply_records(user_id)
    ars = ApplyRecord.where(user_id: user_id)
    apply_records = []
    ars.each do |ar|
      job = Job.find_by_id ar.job_id
      hospital = Hospital.find job.hospital_id

      a = {
        id: ar.id,
        job_name: job.name,
        salary_range: job.salary_range,
        region: job.region,
        resume_status: ar.resume_status,
        recieve_at: ar.recieve_at,
        hospital_name: hospital.name,
        has_new: ar.has_new
      }
      apply_records.push(a)
    end
    apply_records
  end

end
