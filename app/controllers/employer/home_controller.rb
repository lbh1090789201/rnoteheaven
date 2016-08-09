class Employer::HomeController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    # set_vip = Employer.set_vip current_user.id, 1
    @vip_status = Employer.get_status current_user.id
  end

  def index

  end
end
