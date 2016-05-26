class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  def index
    @apply_records = ApplyRecord.select(:id, :resume_id, :job_id, :apply_at,
    :resume_status, :recieve_at).all
    puts 'bbbbbbbbbbb' + @apply_records.to_json.to_s
  end

  def show
  end
end
