class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  helper_method :apply_records_infos
  def index
    @apply_records = ApplyRecord.select(:id, :resume_id, :job_id, :apply_at,
    :resume_status, :recieve_at).all
    puts 'bbbbbbbbbbb' + @apply_records.to_json.to_s
    @hospitals = Hospital.all
  end

  def show
  end
end
