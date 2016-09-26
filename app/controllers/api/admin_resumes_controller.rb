class Api::AdminResumesController < AdminController
    before_action :require_resumes_manager!
    protect_from_forgery :except => [:create]

    # 导出excel表格
    def create

      ids = params[:ids].split(",")

      apply_records = ApplyRecord.where(id: ids)
      @resumes = []
      apply_records.each do |a|
        resume = Resume.get_resume_deliver a
        @resumes.push resume
      end


      number = rand(1000)
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet

      sheet1.row(0).concat %w{序号 投递职位 投递公司 求职者姓名 性别 年龄 电话 工作年限 最高学历 专业 毕业院校 市 工作地点 投递时间}
      index = 0
      @resumes.each do |r|
        index += 1
        row = sheet1.row(index)
        row.push index
        row.push r["apply_record"]["job_name"]
        row.push r["hospital_name"]
        row.push r["apply_record"]["show_name"]
        row.push r["apply_record"]["sex"]
        row.push (r["apply_record"]["age"].to_s + "岁")
        row.push r["cellphone"]
        row.push r["apply_record"]["start_work_at"]
        row.push r["apply_record"]["highest_degree"]
        row.push r["major"]
        row.push r["college"]
        row.push r["job_region"]
        row.push r["apply_record"]["job_location"]
        row.push r["apply_record"]["created_at"].strftime("%Y-%m-%d")

        row.height = 20
      end
      sheet1.row(0).height = 20
      sheet1.column(0).width = 5
      sheet1.column(1).width = 30
      sheet1.column(2).width = 30
      sheet1.column(3).width = 23
      sheet1.column(4).width = 10
      sheet1.column(5).width = 15
      sheet1.column(6).width = 15
      sheet1.column(7).width = 15
      sheet1.column(8).width = 15
      sheet1.column(9).width = 30
      sheet1.column(10).width = 30
      sheet1.column(11).width = 15
      sheet1.column(12).width = 30
      sheet1.column(13).width = 15

      excel = "tmp/简历.xls"
      book.write excel
      send_file File.new(excel), type: "charset=utf-8"

    end

end
