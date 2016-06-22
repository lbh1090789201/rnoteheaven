class Employer::HomeController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    @vip_status = Employer.get_status current_user.id
  end

  def index

  end
end
