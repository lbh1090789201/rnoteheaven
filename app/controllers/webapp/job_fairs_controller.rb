class Webapp::JobFairsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    @fairs = Fair.where(status: 'processing')
    # @fairs = []
    # fairs.each do |f|
    #   o = {
    #     fair = f,
    #     left_end = ((f.end_at - Time.now)/1.day).to_i
    #   }
    #   @fairs.push(o)
    # end
    # return @fairs
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

end
