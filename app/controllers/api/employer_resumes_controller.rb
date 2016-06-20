class Api::EmployerResumesController < ApiController
  # before_action :require_employer!   # 登陆验证
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:update]

  # 需要传入 apply_record_id， resume_status #简历状态 1.筛选 2.面试 3.不合适
  def update
    apply_record = ApplyRecord.find params[:apply_record_id]

    if apply_record.update_attributes(resume_status: params[:resume_status])
      render json: {
        success: true,
        info: "简历状态更新成功！",
        data: params[:resume_status]
      }, status: 200
    else
      render json: {
        success: false,
        info: "简历状态更新失败。",
      }, status: 403
    end
  end

end
