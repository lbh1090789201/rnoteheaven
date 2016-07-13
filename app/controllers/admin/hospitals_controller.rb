class Admin::HospitalsController < AdminController
  before_action :require_hospitals_manager!

  def index
    hospitals = Hospital.all
    @hospitals = Hospital.get_info hospitals
    @vip_levels = Plan.all

    # if params[:search]
    #   @employers = Employer.where(vip_level: params[:vip_level])
    #   ids = []
    #   @employers.each do |f|
    #     ids.push f.hospital_id
    #   end
    #
    #   hospitals = Hospital.where id: ids
    #
    #   hospitals.filter_by_property(params[:property])
    #             .filter_hospital_name(params[:hospital_name])
    #             .filter_create_before(params[:time_before])
    #             .filter_create_after(params[:time_after])
    #
    #   @hospital_infos = Hospital.get_info hospitals
    # end


  end
end
