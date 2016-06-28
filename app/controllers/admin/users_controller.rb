class Admin::UsersController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index
    if params[:filter]
      @users = User.filter_user_status('reviewing')
                 .filter_release_before(params[:time_before])
                 .filter_release_before(params[:time_after])
                 .filter_user_type(params[:user_type])
                 .filter_hospital_name(params[:hospital_name])
                 .filter_user_name(params[:user_name])
    else
      @users = User.all
    end
  end

  def edit
  end
end
