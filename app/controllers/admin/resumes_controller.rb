class Admin::ResumesController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index
    if params[:filter]
      @resumes = Resume.filter_by_city(params[:filter][:city])
                       .filter_show_name(params[:filter][:show_name])
                       .filter_is_public(params[:filter][:public])
                       .find_by(id: params[:filter][:resume_id])

      @resumes = @resumes.filter_is_freeze if params[:filter][:freeze]
    else
      @resumes = Resume.all
    end

  end

  def edit
  end
end
