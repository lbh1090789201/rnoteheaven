class Admin::FairHospitalsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create, :update]

  def index
    if params[:search]
      golds = Hospital.filter_hospital_name params[:name]
                      .filter_contact_person params[:contact_person]

      golds = golds.where(id: params[:id]) if params[:id]

      render json: {
        success: true,
        info: '动态搜索成功！',
        golds: golds
      }, status: 200
    else
      @fair = Fair.find params[:fair_id]
      @fair_hospitals = FairHospital.where fair_id: @fair.id
    end
  end
end
