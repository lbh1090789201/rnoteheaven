class Admin::FairHospitalsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create, :update]

  def index
    if params[:search]
      golds = Hospital.filter_hospital_name(params[:name])
                      .filter_contact_person(params[:contact_person])
      golds = golds.where(id: params[:id]) if params[:id].present?
      p '---------------'
      p golds

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

  def create
    fair_hospital = FairHospital.new fair_hospitals_params
    fair_hospital.user_id = current_user.id
    fair_hospital.operator = current_user.show_name

    if fair_hospital.save
      render json: {
        success: true,
        info: '添加机构成功！',
        fair_hospital: fair_hospital
      }, status: 200
    else
      render json: '添加机构失败。', status: 403
    end
  end

  private
    def fair_hospitals_params
      params.permit(:hospital_id, :fair_id, :contact_person, :contact_number,
                    :intro, :banner, :status, :operator)
    end

end
