class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!

  def index
    @hospitals = Hospital.all

    if params[:search]
      @hospitals = Hospital.filter_by_property(params[:property])
                          .filter_hospital_name(params[:hospital_name])
                          .filter_create_before(params[:time_before])
                          .filter_create_after(params[:time_after])
    end


  end
end
