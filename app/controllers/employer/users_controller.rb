class Employer::UsersController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    @hospital = Employer.get_hospital current_user.id
    @vip_status = Employer.get_status current_user.id
  end

  def index
    @user = current_user
    @user.avatar_url.blank? ? @avatar = "icon_29.png" : @avatar = @user.avatar_url
    fair_hospital = FairHospital.find_by hospital_id: @hospital.id
    @fair_info = fair_info fair_hospital
  end

  def show
    # 显示 vip 参数
    @employer = Employer.find_by user_id: current_user.id
  end

  def edit

  end

  def update
    if @hospital.update_columns hospital_params
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
      params.require(:hospital).permit(:name, :property, :scale, :industry, :region, :location, :introduction)
    end

    def fair_info fair_hospital
      if fair_hospital.present?
        fair = Fair.find fair_hospital.fair_id
        info = {
          name: fair.name,
          text: '参加中'
        }
      else
        info = {
          name: '未参与专场',
          text: ''
        }
      end
      puts '------------'
      puts info.class
      return info
    end
end
