module Webapp::ApplyRecordsHelper

      #获取应聘记录
      def get_apply_records(user_id)
        apply_records = ApplyRecord.where(user_id: user_id)
      end

      #获取职位信息
      def get_job_infos(apply_records_job_id)
        job_infos = Job.find_by_id apply_records_job_id
      end

      # 获取数据
      def get_date(user_id)
        apply_records = ApplyRecord.get_apply_records(user_id)
        applyrecords = []
        apply_records.each do |apply_record|
          job_info = Job.get_job_infos(apply_record.job_id)
          puts 'aaaaaaaaa' + job_infos
          a = {
            id:apply_record.id,
            job_name:job_info.name,
            salary_range:job_info.salary_range,
            location:job_info.location,
            resume_status:apply_record.resume_status
          }
          applyrecords.push(a)
        end
        return applyrecords
      end
end
