class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!
  protect_from_forgery :except => [:index, :update, :create]

  def index
    hospitals = Hospital.all
    @hospitals = Hospital.get_info hospitals
    @vip_levels = Plan.where(status: true)

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

        hospitals = Hospital.where id: ids

        hospital_infos = hospitals.filter_by_property(params[:property])
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
    end


  end

  def update
    hospital = Hospital.find params[:id]
    employer = Employer.find_by hospital_id: hospital.id
    employer = Employer.set_plan employer.user_id, params[:plan_id]

    if hospital.update(hospital_params) && employer.present?
      hospital = Hospital.where(id: params[:id])
      @hospital_infos = hospital.get_info hospital

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
    hospital = hospital.create! hospital_params
    employer = Employer.find_by hospital_id: hospital.id
    employer = Employer.set_plan employer.user_id, params[:plan_id]

    if hospital && employer.present?
      @hospital_infos = hospital.get_info hospital

      render json: {
        success: true,
        info: "新建成功",
        hospital: @hospital_infos
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
                                        :location, :introducion, :contact_person)
  end

  def employer_params
    params.permit(:plan_id)
  end

end
