class Employer::HomeController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
    # hospital = Employer.find_by user_id: current_user.id
  end
end
