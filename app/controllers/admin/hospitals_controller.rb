class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!
  protect_from_forgery :except => [:index, :update, :create, :destroy]

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
    my_hospital = Hospital.find params[:id]

    unless my_hospital.contact_number == hospital_params[:contact_number]
      is_repeate = Hospital.find_by contact_number: hospital_params[:contact_number]
      if is_repeate
        render json: {
          success: false,
          info: "此帐号已被使用。"
        }, status: 403
        return
      end
    end




    hospital = Hospital.find params[:id]
    employer = Employer.find_by hospital_id: hospital.id
    employer = Employer.employer_plan employer, params[:plan_id]

    if hospital.update(hospital_params) && employer.present?
      hospital = Hospital.where(id: params[:id])
      @hospital_infos = Hospital.get_info hospital

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
    is_repeate = Hospital.find_by contact_number: hospital_params[:contact_number]
    if is_repeate
      render json: {
        success: false,
        info: "此帐号已被使用。"
      }, status: 403
      return
    end

    hospital = Hospital.create! hospital_params
    plan_id = employer_params[:plan_id]

    employer = Employer.create! hospital_id: hospital.id
    employer = Employer.employer_plan employer, plan_id

    if hospital
      EventLog.create_log current_user.id, current_user.show_name, 'Hospital', hospital.id, "机构", '新建'
      hospital = Hospital.get_info [hospital]

      render json: {
        success: true,
        info: "新建成功",
        hospital: hospital[0]
      }, status: 200
    else
      render json: {
        success: false,
        info: "新建失败"
      }, status: 403
    end
  end

  def destroy
    hospital = Hospital.find params[:id]
    employer = Employer.find_by hospital_id: hospital.id
    user = User.find_by id: employer.user_id

    EventLog.create_log current_user.id, current_user.show_name, 'Hospital', hospital.id, "机构", '删除'

    if hospital.destroy
      if user.present?
        user.user_type = "copper"
        user.save
        user.remove_role :gold
        employer.destroy
      end

      render json: {
        success: true,
        info: "删除机构成功",
      }, status: 200
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
