class Employer::UsersController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    @hospital = Employer.get_hospital current_user.id
    @vip_status = Employer.get_status current_user.id
  end

  def index

  end

  def show
    # 显示 vip 参数
    @employer = Employer.find_by user_id: current_user.id
  end

  def edit

  end

  def update
    if @hospital.update hospital_params
      render js: "location.href = document.referrer;"
    else
      render json: {
        success: false,
        info: "医院信息更新失败"
      }, status: 403
    end
  end

  private
    def hospital_params
      params.require(:hospital1).permit(:name, :property, :scale, :industry, :region, :location, :introduction)
    end
end
