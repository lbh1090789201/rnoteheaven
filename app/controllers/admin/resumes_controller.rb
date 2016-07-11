class Admin::ResumesController < ApplicationController
  before_action :require_admin!
  protect_from_forgery :except => [:index, :update]
  layout 'admin'

  def index
    if params[:search]
      resumes = Resume.filter_is_public(params[:public])
                      .filter_by_city(params[:location])
                      .filter_show_name(params[:show_name])

      resumes = resumes.where(id: params[:rid]) if params[:rid].present?

      resumes = resumes.filter_is_freeze if params[:resume_freeze].present?
      @resumes = get_info resumes


      render json: {
        success: true,
        info: '筛选简历成功',
        resumes: @resumes
      }, status: 200

    else
      resumes = Resume.all
      @resumes = get_info resumes
    end

    if params[:resume_id]
      @resume = Resume.get_resume_info params[:resume_id]
      # @resume = Resume.find params[:resume_id]
      puts "--------" + @resume.to_json.to_s

      render json: {
        success: true,
        info: "获取resume成功",
        resume: @resume,
      }, status: 200
    end
 end

 def update
    if params[:ids] && !params[:ids].blank?
      ids = params[:ids].split(',')
      resumes = Resume.where(id: ids)

      resumes.each do |f|
        f.resume_freeze = params[:status]
        f.save
      end

       @resumes = get_info resumes

      render json: {
        success: true,
        info: '简历操作成功',
        resumes: @resumes
      }, status: 200
    else
      render json: '简历操作成功，检查您是否勾选简历', status: 403
    end
 end


  private
    def get_info resumes
      @resumes = []
      resumes.each do |f|
        resume = Resume.get_info f
        @resumes.push resume
      end

      return @resumes
    end
end


#接口说明 @resumes 类型：数组 JSON
# [{"id":287,"user_id":1107,"re
# fresh_at":"2016-07-07T08:14:08.014Z","expected_job":"护士","expected_job_type":"全职","expected_base":"北京","expected_salary_rang
# e":"5k~6k","maturity":5,"public":true,"resume_freeze":false,"created_at":"2016-07-07T08:14:12.750Z","updated_at":"2016-07-07T08:14
# :12.750Z","show_name":"Ming","location":"武汉","apply_count":2,"viewed_count":1},...]
