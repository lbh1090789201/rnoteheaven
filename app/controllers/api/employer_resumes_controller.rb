class Api::EmployerResumesController < ApiController
  # before_action :require_employer!   # 登陆验证
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:update]

  # 医院审核简历后传入 apply_record_id， resume_status #简历状态 1.不合适 2.面试
  # 应聘者查看有红点的简历 apply_record_id，has_new #有更更新 'false'
  def update
    apply_record = ApplyRecord.find params[:apply_record_id]

    if params[:has_new].nil? && params[:resume_status]
      apply_record.update_columns(resume_status: params[:resume_status], end_at: Time.now, has_new: true)
      render json: {
        success: true,
        info: "简历状态更新成功！",
        data: params[:resume_status]
      }, status: 200
    elsif !params[:has_new].nil? && !params[:resume_status]
      apply_record.update_columns(has_new: false)
      render json: {
        success: true,
        info: "应聘者已查看简历更新！"
      }, status: 200
    else
      render json: {
        success: false,
        info: "Api::EmployerResumesController update传入参数错误",
      }, status: 403
    end
  end

end
