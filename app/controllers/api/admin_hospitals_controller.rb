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
    end

    private

    def hospitals_params
      tmp = params[:hospital]
      # 读取csv文件
      csv_text = File.read(tmp.path)

      csv = CSV.parse(csv_text,:headers => true)

      @hospitals = []
      csv.each do |row|
        hospital_text = row[0].to_s
        array = hospital_text.split('@')
        o = {
          name: array[0],
          contact_number: array[1],
          contact_person: array[2],
          property: array[3],
          scale: array[4],
          industry: array[5],
          region: array[6],
          location: array[7],
          lng: array[8],
          lat: array[9],
          introduction: array[10],
          vip_name: array[11],
        }
        @hospitals.push o
      end
      return @hospitals
    end
end
