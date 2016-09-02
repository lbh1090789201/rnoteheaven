class Api::AdminHospitalsController < AdminController
    before_action :require_hospitals_manager!
    protect_from_forgery :except => [:update]

    # 上传文件格式为execl表格
    def create
      # 验证execl单元格的字段
      i = 1
      hospitals_params.each do |h|
        i = i + 1
        reg_introduction = /^.{6,500}$/
        reg_contact_number = /^1[345678][0-9]{9}$/
        reg_pattern = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/
        reg_length = /^.{0,15}$/
        reg_lng = /^[+-]?\d+(\.\d+)?$/
        reg_vip_name = /^.{1,10}$/

        if reg_pattern.match(h[:name]).nil? || reg_length.match(h[:name]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的机构名称格式不对: " + h[:name],
          }, status: 403
          return
        end

        if reg_contact_number.match(h[:contact_number]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的电话号码格式不对: " + h[:contact_number],
          }, status: 403
          return
        end

        if reg_pattern.match(h[:contact_person]).nil? || reg_length.match(h[:contact_person]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的负责人格式不对!",
          }, status: 403
          return
        end

        if reg_length.match(h[:property]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的性质格式不对!",
          }, status: 403
          return
        end

        if reg_length.match(h[:scale]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的规模格式不对!",
          }, status: 403
          return
        end

        if reg_length.match(h[:industry]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的行业格式不对!" ,
          }, status: 403
          return
        end

        if reg_length.match(h[:region]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的地区格式不对!",
          }, status: 403
          return
        end

        if reg_length.match(h[:location]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的地址格式不对!",
          }, status: 403
          return
        end

        if reg_lng.match(h[:lng]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的经度格式不对!",
          }, status: 403
          return
        end

        if reg_lng.match(h[:lat]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的纬度格式不对!",
          }, status: 403
          return
        end

        if reg_introduction.match(h[:introduction]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的机构介绍格式不对!",
          }, status: 403
          return
        end

        if reg_vip_name.match(h[:vip_name]).nil?
          render json: {
            success: false,
            info: "第"+ i.to_s + "行的套餐名称格式不对!",
          }, status: 403
          return
        end
      end

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
