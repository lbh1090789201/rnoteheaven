class Webapp::HospitalsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    job = Job.find_by params[:id]
    @hospital = Hospital.find_by job.hospital_id
    @jobs = Job.where(:hospital_id => @hospital.id)
  end
  def show
    job = Job.find_by params[:id]
    @hospital = Hospital.find_by job.hospital_id
    @jobs = Job.where(:hospital_id => @hospital.id)
  end
end
