class Admin::DataStatisticsController < AdminController
  def index

    if params[:search]
        @data_statistic = []
        if params[:time_from].present? && params[:time_to].present?
          from = params[:time_from].to_time
          to = params[:time_to].to_time
          @times = time_block(from, to)
          @data_statistic.push @times
        end

        @apply_records = []
        if !params[:resume_deliver].blank?
          5.times{|i|
            apply_records = ApplyRecord.filter_time_from(@times[i])
                                       .filter_time_to(@times[i + 1])
                                       .size
            @apply_records.push apply_records
          }
        end

        @job_releases = []
        if !params[:job_release].blank?

          5.times{|i|
            job_releases = Job.filter_release_from(@times[i])
                              .filter_release_to(@times[i + 1])
                              .size
            @job_releases.push job_releases
          }
        end

        @job_delivers = []
        if !params[:hot_job].blank?
          job = Job.find_by name: params[:hot_job]

          if job
            5.times{|i|
              job_delivers = ApplyRecord.filter_time_from(@times[i])
                                         .filter_time_to(@times[i + 1])
                                         .where(job_id: job.id)
                                         .size
              @job_delivers.push job_delivers
            }
          end
        end

        @hospital_delivers = []
        if !params[:hot_hospital_deliver].blank?
          @hospital_delivers = get_hospital_delivers(params[:hot_hospital_deliver])
        end

        @hospital_collects = []
        if !params[:hot_job_collect].blank?
          @hospital_collects = get_hospital_collects params[:hot_job_collect]
        end


        @data_statistic.push @apply_records
        @data_statistic.push @job_releases
        @data_statistic.push @job_delivers
        @data_statistic.push @hospital_delivers
        @data_statistic.push @hospital_collects

        p @data_statistic
        render json: {
          success: true,
          info: "搜索成功",
          data_statistic: @data_statistic,
        }, status: 200
    end
  end

  private

  def time_block(time_start, time_end)
    if (time_start + 5.days) > time_end
      i = (time_end - time_start)/(5*1.hours)
      times = [time_start.strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.hours*i).strftime("%Y-%m-%d %H:%M:%S"),
                (time_start + 1.hours*i*2).strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.hours*i*3).strftime("%Y-%m-%d %H:%M:%S"),
                (time_start + 1.hours*i*4).strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.hours*i*5).strftime("%Y-%m-%d %H:%M:%S") ]
    elsif (time_start + 5.days) < time_end
      i = (time_end - time_start)/(5*1.days)
      times = [time_start.strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.days*i).strftime("%Y-%m-%d %H:%M:%S"),
                (time_start + 1.days*i*2).strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.days*i*3).strftime("%Y-%m-%d %H:%M:%S"),
                (time_start + 1.days*i*4).strftime("%Y-%m-%d %H:%M:%S"), (time_start + 1.days*i*5).strftime("%Y-%m-%d %H:%M:%S") ]
    end
    return times
  end

  # admin 数据统计　得到医院的投递数
  def get_hospital_delivers hospital_name
      hospital = Hospital.find_by name: hospital_name
      hospital_delivers = []
      if hospital
        jobs = Job.where(hospital_id: hospital.id)

        if !jobs.blank?
          apply_numbers = []
          jobs.each do |j|
            apply_number = []
            5.times{|i|
              job_delivers = ApplyRecord.filter_time_from(@times[i])
                                         .filter_time_to(@times[i + 1])
                                         .where(job_id: j.id)
                                         .size
              apply_number.push job_delivers
            }
            apply_numbers.push apply_number
          end
          hospital_delivers[0] = apply_numbers[0][0] + apply_numbers[1][0] + apply_numbers[2][0] + apply_numbers[3][0] + apply_numbers[4][0]
          hospital_delivers[1] = apply_numbers[0][1] + apply_numbers[1][1] + apply_numbers[2][1] + apply_numbers[3][1] + apply_numbers[4][1]
          hospital_delivers[2] = apply_numbers[0][2] + apply_numbers[1][2] + apply_numbers[2][2] + apply_numbers[3][2] + apply_numbers[4][2]
          hospital_delivers[3] = apply_numbers[0][3] + apply_numbers[1][3] + apply_numbers[2][3] + apply_numbers[3][3] + apply_numbers[4][3]
          hospital_delivers[4] = apply_numbers[0][4] + apply_numbers[1][4] + apply_numbers[2][4] + apply_numbers[3][4] + apply_numbers[4][4]
      end
    end
    return hospital_delivers
  end

  # admin 数据统计　得到医院的收藏数
  def get_hospital_collects hospital_name
    users = User.all
    index = [0, 0, 0, 0, 0]
    users.each do |u|
       5.times{|i|
         favorite_jobs = FavoriteJob.filter_time_from(@times[i])
                                    .filter_time_to(@times[i + 1])
                                    .where(user_id: u.id)

         if !favorite_jobs.blank?
           y = 0
           favorite_jobs.each do |f|
             job = Job.find f.job_id
             hospital = Hospital.find job.hospital_id if job.present?
             if hospital.name == params[:hot_job_collect] && y < 1
               y += 1
             else
               y += 0
             end
           end
           index[i] += y
         end
       }
    end
    return index
  end
end
