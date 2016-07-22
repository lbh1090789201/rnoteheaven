class Webapp::JobFairsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    fairs = Fair.where(status: 'processing')
    fairs.each do |f|
      f.end_at = time_diff Time.now, f.end_at
    end
    @fairs = fairs
    @fairs_length = @fairs.length
  end

  def show
    @fair = Fair.find params[:id]
    fair_hospitals = FairHospital.where(fair_id: @fair.id, status: 'on')

    @fair_hospitals = []

    fair_hospitals.each do |f|
      hospital = Hospital.find f.hospital_id
      apply_record =ApplyRecord.where(hospital_id: hospital.id).length
      o = {
        fair_id: f.fair_id,
        banner: f.banner,
        hospital: hospital,
        apply_length: apply_record,
      }
      @fair_hospitals.push o
    end
    return @fair_hospitals

  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
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

end
