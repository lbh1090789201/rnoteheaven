class Employer::JobsController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
    @hospital = Employer.get_hospital current_user.id
    @jobs = Job.where(hospital_id: @hospital.id)
  puts "--------"+@jobs.to_json.to_s
    @jobs.each do |f|
      f.status = "end" if Time.new > f.end_at
      f.save
    end

  end

  def show
    @job = Job.find params[:id]
    @time_left = Job.time_left @job.id
  end
end
