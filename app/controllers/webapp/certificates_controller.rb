class Webapp::CertificatesController < ApplicationController

  protect_from_forgery except: [:create, :destroy]

  def index
    @certificates = Certificate.where user_id: current_user.id
    @resume = Resume.find_by(user_id: current_user.id)
  end

  def new
    @Certificate = Certificate.new
  end

  def create
    certificate = Certificate.create certificate_params
    certificate.user_id = current_user.id

    if certificate.save
      render js: 'location.href = document.referrer'
    else
      redirect_to :back, alert: "证书添加失败"
    end
  end

  def destroy
    certificate = Certificate.find params[:id]

    if certificate.destroy
      render json: {
        success: true,
        info: "删除证书成功！"
      }, status: 200
    else
      render json: {
        success: true,
        info: "删除证书失败！"
      }, status: 403
    end
  end

  private
  def certificate_params
    params.permit(:title)
  end
end
