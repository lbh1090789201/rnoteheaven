class Admin::JobsController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index

  end

  def check
    if params[:filter]
      @jobs = Job.filter_job_status('reviewing')
                 .filter_release_before(params[:time_before])
                 .filter_release_before(params[:time_after])
                 .filter_job_type(params[:job_type])
                 .filter_hospital_name(params[:hospital_name])
                 .filter_job_name(params[:job_name])
    else
      @jobs = Job.filter_job_status('reviewing').as_json
    end
  end

  def edit
  end
end
