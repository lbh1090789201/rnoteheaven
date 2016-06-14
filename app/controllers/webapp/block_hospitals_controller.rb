class Webapp::BlockHospitalsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: [:create, :destroy]

  def index
    @blockhospitals = BlockHospital.where user_id: current_user.id
  end

  def new
    @blockhospital = BlockHospital.new
  end

  def create
    blockhospital = BlockHospital.create blockhospital_params
    blockhospital.user_id = current_user.id

    if blockhospital.save
      render js: "history.go(-1)"
    else
      redirect_to :back, alert: "证书添加失败"
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
    params.require(:block_hospital).permit(:hospital_name)
  end
end
