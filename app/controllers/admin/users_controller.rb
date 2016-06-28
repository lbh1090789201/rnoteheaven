class Admin::UsersController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index
    if params[:filter]
      @users = User.filter_user_status('reviewing')
                 .filter_create_before(params[:time_before])
                 .filter_create_after(params[:time_after])
      @users = User.find params[:user_id] if params[:user_id]
    else
      @users = User.all
    end
  end

  def edit
  end
end
