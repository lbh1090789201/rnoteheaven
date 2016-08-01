class Admin::FairHospitalsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create, :update]

  def index
    if params[:search]
      golds = Hospital.filter_hospital_name(params[:name])
                      .filter_contact_person(params[:contact_person])
      golds = golds.where(id: params[:id]) if params[:id].present?

      render json: {
        success: true,
        info: '动态搜索成功！',
        golds: golds
      }, status: 200
    else
      @fair = Fair.find params[:fair_id]
      fair_hospitals = FairHospital.where fair_id: @fair.id
      @fair_hospitals = FairHospital.get_info fair_hospitals

    end
  end

  def create
    is_repeate = FairHospital.find_by(
      hospital_id: fair_hospitals_params[:hospital_id],
      fair_id: fair_hospitals_params[:fair_id]
    )

    if is_repeate
      render json: {
        success: false,
        info: "此机构已添加。"
      }, status: 403
      return
    end

    fair_hospital = FairHospital.new fair_hospitals_params
    fair_hospital.user_id = current_user.id
    fair_hospital.operator = current_user.show_name

    if fair_hospital.save
      EventLog.create_log current_user.id, current_user.show_name, 'FairHospital', fair_hospital.id, "专场机构", '添加'

      fair_hospital = FairHospital.statistic fair_hospital
      render json: {
        success: true,
        info: '添加机构成功！',
        fair_hospital: fair_hospital
      }, status: 200
    else
      render json: '添加机构失败。', status: 403
    end
  end

  def update
    fair_hospital = FairHospital.find params[:id]
    fair_hospital.update! fair_hospitals_params
    EventLog.create_log current_user.id, current_user.show_name, 'FairHospital', fair_hospital.id, "专场机构", '修改'

    fair_hospital = FairHospital.statistic fair_hospital

    render json: {
      success: true,
      info: '更新机构成功！',
      fair_hospital: fair_hospital
    }, status: 200
  end

  private
    def fair_hospitals_params
      params.permit(:hospital_id, :fair_id, :contact_person, :contact_number,
                    :intro, :banner, :status, :operator)
    end

    def other_params
      params.permit(:id)
    end
end
