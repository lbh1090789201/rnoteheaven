class Webapp::HospitalsController < ApplicationController
  before_action do
    :authenticate_user!   # 登陆验证
    @hospital = Hospital.find params[:id]
    @jobs = Job.where(:hospital_id => @hospital.id)
  end

  def index
  end

  def show
  end
end
