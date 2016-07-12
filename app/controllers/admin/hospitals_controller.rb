class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!

  def index
  end
end
