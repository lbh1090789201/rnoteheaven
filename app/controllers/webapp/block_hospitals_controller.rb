class Webapp::BlockHospitalsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: [:create, :destroy]

  def index
    @blockhospitals = BlockHospital.where user_id: current_user.id
    @resume = Resume.find_by_user_id current_user.id
  end

  def new
    @blockhospital = BlockHospital.new

    if blockhospital_params[:hospital_name] && !blockhospital_params[:hospital_name].blank?
      name = blockhospital_params[:hospital_name]
      hospitals = Hospital.where('name LIKE ?', "%#{name}%")
      render json: {
        success: true,
        info: "查询医院成功",
        hospitals: hospitals
      }, status: 200
    end
  end

  def create
    block_item = BlockHospital.find_by(hospital_id: blockhospital_params[:hospital_id], user_id: current_user.id)
    if block_item
      render js: "FailMask('.container','此医院已屏蔽，请勿重复提交。')"
    else
      blockhospital = BlockHospital.new blockhospital_params
      blockhospital.user_id = current_user.id
      if blockhospital.save
        render js: "location.href=document.referrer"
      else
        redirect_to :back, alert: "屏蔽医院失败"
      end
    end
  end

  def destroy
    blockhospital = BlockHospital.find params[:id]

    if blockhospital.destroy
      render json: {
        success: true,
        info: "删除屏蔽医院成功！"
      }, status: 200
    else
      render json: {
        success: true,
        info: "删除屏蔽医院失败！"
      }, status: 403
    end
  end

  private
  def blockhospital_params
    params.permit(:hospital_name, :hospital_id)
  end
end
