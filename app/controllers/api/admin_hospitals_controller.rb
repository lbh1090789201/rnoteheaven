class Api::AdminHospitalsController < AdminController
    before_action :require_hospitals_manager!
    protect_from_forgery :except => [:update]

    # 上传文件格式必须为csv
    def create
      @hospitals = []
      hospitals_params.each do |h|
       hospital = Hospital.find_by contact_number: h[:contact_number] if h[:contact_number].present?
       plan = Plan.find_by name: h[:vip_name] if h[:vip_name].present?

       if hospital
         render json: {
           success: false,
           info: "存在重复账号！" + "—" + h[:contact_number],
         }, status: 403
         return
       end

       if !plan.present?
         render json: {
           success: false,
           info: "不存在指定套餐！"+ "—" + h[:vip_name],
         }, status: 403
         return
       end
      end

      hospitals_params.each do |hospital_params|
        plan = Plan.find_by name: hospital_params[:vip_name] if hospital_params[:vip_name].present?
        hospital_params.delete(:vip_name)
        hospital = Hospital.create! hospital_params
        employer = Employer.create! hospital_id: hospital.id
        employer = Employer.employer_plan employer, plan.id

        if hospital
          EventLog.create_log current_user.id, current_user.show_name, 'Hospital', hospital.id, "机构", '新建'

        else
          render json: {
            success: false,
            info: "批量创建机构失败！"
          }, status: 403
        end
      end

      render json: {
        success: true,
        info: "批量创建机构成功！",
      }, status: 200




      # hospitals_params
    end

    private

    def hospitals_params

      tmp = params[:hospital]

      xlsx = Roo::Spreadsheet.open(tmp.path, extension: :xlsx)

      @hospitals = []
      xlsx.each do |row|
        o = {
          name: row[0].to_s,
          contact_number: row[1].to_s,
          contact_person: row[2],
          property: row[3].to_s,
          scale: row[4].to_s,
          industry: row[5].to_s,
          region: row[6].to_s,
          location: row[7].to_s,
          lng: row[8].to_s,
          lat: row[9].to_s,
          introduction: row[10].to_s,
          vip_name: row[11].to_s,
        }
        @hospitals.push o
      end
      @hospitals.shift
      return @hospitals
    end
end
