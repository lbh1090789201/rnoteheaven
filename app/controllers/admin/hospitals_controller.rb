class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!
  protect_from_forgery :except => [:index, :update, :create]

  def index

    if params[:hide_search]
      if params[:vip_id].blank?
        hospitals = Hospital.filter_by_property(params[:property])
                                  .filter_hospital_name(params[:hospital_name])
                                  .filter_create_before(params[:time_before])
                                  .filter_create_after(params[:time_after])

        @hospital_infos = Hospital.get_info hospitals
      else
        @employers = Employer.where(plan_id: params[:vip_id])
        ids = []
        @employers.each do |f|
          ids.push f.hospital_id
        end

        hospital_infos = Hospital.where(id: ids).filter_by_property(params[:property])
                  .filter_hospital_name(params[:hospital_name])
                  .filter_create_before(params[:time_before])
                  .filter_create_after(params[:time_after])

        @hospital_infos = Hospital.get_info hospital_infos
      end

      render json: {
        success: true,
        info: "搜索成功",
        hospital: @hospital_infos
      }, status: 200
    else
      hospitals = Hospital.all
      @hospitals = Hospital.get_info hospitals
      @hospitals = Kaminari.paginate_array(@hospitals).page(params[:page]).per(8)
      @vip_levels = Plan.where(status: true)
    end


  end

  def update
    hospital = Hospital.find params[:id]
    employer = Employer.find_by hospital_id: hospital.id
    employer = Employer.set_plan employer.user_id, params[:plan_id]

    if hospital.update(hospital_params) && employer.present?
      hospital = Hospital.where(id: params[:id])
      @hospital_infos = hospital.get_info hospital

      EventLog.create_log current_user.id, current_user.show_name, 'Hospital', hospital[0].id, "机构", '更新'
      render json: {
        success: true,
        info: "更新成功",
        hospital: @hospital_infos
      }, status: 200
    else
      render json: {
        success: false,
        info: "更新失败"
      }, status: 403
    end
  end

  def create
    hospital = Hospital.create! hospital_params

    if hospital
      EventLog.create_log current_user.id, current_user.show_name, 'Hospital', hospital.id, "机构", '新建'
      render json: {
        success: true,
        info: "新建成功",
        hospital: hospital
      }, status: 200
    else
      render json: {
        success: false,
        info: "新建失败"
      }, status: 403
    end
  end

  private

  def hospital_params
    params.permit(:name, :industry, :property, :scale, :region, :contact_number,
                         :lng, :lat, :location, :introduction, :contact_person, :lng, :lat)
  end

  def employer_params
    params.permit(:plan_id)
  end

end
