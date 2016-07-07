include Webapp::ApplyRecordsHelper

class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  helper_method :apply_records_infos

  def index
    @data = get_apply_records(current_user.id)
  end

  def show
    @apply_record = ApplyRecord.find params[:id]
    resume_status = @apply_record.resume_status
    view_at = @apply_record.view_at
    @apply_status = get_apply_status(resume_status, view_at)
    @hospital = Hospital.find_by @apply_record.hospital_id
  end

  def get_apply_status(resume_status, view_at)

    if view_at && resume_status != "筛选"
      return {css: "apply_end"}
    else
      if view_at && resume_status == "筛选"
        return {css: "apply_view"}
      else
        return {css: "apply_recieve"}
      end
    end
  end
end
