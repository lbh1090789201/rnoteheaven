class Admin::VipsController < AdminController
  before_action :require_vips_manager!

  def index
  end
end
