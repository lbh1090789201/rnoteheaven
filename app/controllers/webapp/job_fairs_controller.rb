class Webapp::JobFairsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    fairs = Fair.where(status: 'processing')
    @fairs = []
    fairs.each do |f|
      fair = f.as_json
      fair["time_left"] = time_left(Time.now, f.end_at)
      fair["hospital_num"] = FairHospital.where(fair_id: f["id"], status:"on").length
      @fairs.push fair
    end
    user = User.find current_user.id
    @cellphone = user.cellphone if user.present?
  end

  def show
    @fair = Fair.find params[:id]
    @fair_name = @fair.name
    fair_hospitals = FairHospital.where(fair_id: @fair.id, status: 'on')
      @fair_jobs = []

      fair_hospitals.each do |f|
        hospital = Hospital.find f.hospital_id
        # apply_record =ApplyRecord.where(hospital_id: hospital.id).length
        jobs = Job.where(hospital_id: hospital.id, status: "release")

        if !jobs.blank?
          jobs.each do |j|
            o = {}
              o["id"] = j.id
              o["fair_id"] = f.fair_id
              o["name"] = j.name
              o["hospital_name"] = hospital.name
              o["salary_range"] = j.salary_range
              o["region"] = j.region

            @fair_jobs.push o
          end
        end


      end
      return @fair_jobs
  end

  private
    def time_diff(start_time, end_time)
      seconds_diff = (start_time - end_time).to_i.abs

      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff
      "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    end

    def time_left(start_time, end_time)
      seconds_diff = (start_time - end_time).to_i.abs
    end

end
