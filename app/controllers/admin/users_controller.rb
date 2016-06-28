class Admin::UsersController < ApplicationController
  before_action :require_admin!
  layout 'admin'

  def index
  end

  def edit
  end
end
