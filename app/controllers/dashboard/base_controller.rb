# used for user's administrator
class Dashboard::BaseController < ApplicationController
  before_filter :require_admin_role!
  layout 'dashboard'

  def index

  end

  private
  def require_admin_role!
    unless can_dashboard?
      flash[:error] = "You must be logged in as administrator"
      redirect_to "/" # halts request cycle
    end
  end

  def can_dashboard?
    return false unless current_user
    return true if current_user.has_role? :admin
    return true if current_user.has_role? :gold
    false
  end
end
