class Admin::VipsController < AdminController
  before_action :require_vips_manager!
    # set_vip = Employer.set_vip current_user.id, 1

  def index
  end
end
