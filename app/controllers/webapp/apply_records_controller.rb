include Webapp::ApplyRecordsHelper

class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  helper_method :apply_records_infos

  def index
    @data = get_apply_records(current_user.id)
  end

  def show
    @apply_record = ApplyRecord.find_by(params[:id])
    @job = Job.find_by @apply_record.job_id
    @hospital = Hospital.find_by @job.hospital_id
    @applyrecord = []
    o = {
      id: @apply_record.job_id,
      job_name: @job.name,
      salary_range: @job.salary_range,
      created_at: @apply_record.created_at,
      hospital_name: @hospital.name,
      resume_status: @apply_record.resume_status,
      apply_at: @apply_record.apply_at,
      view_at: @apply_record.view_at,
      recieve_at: @apply_record.recieve_at,
      location: @job.location
    }
    @applyrecord.push(o)
    puts "-----"+@applyrecord.to_json
  end
end
