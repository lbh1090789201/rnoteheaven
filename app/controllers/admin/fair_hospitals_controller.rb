class Admin::FairHospitalsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create, :update]

  def index
    @fair = Fair.find params[:fair_id]
  end
end
