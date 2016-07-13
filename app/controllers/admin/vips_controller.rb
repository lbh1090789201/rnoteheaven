class Admin::VipsController < AdminController
  before_action :require_vips_manager!
    # set_vip = Employer.set_vip current_user.id, 1
    protect_from_forgery :except => [:index, :create]

  def index
    @vips = Plan.all
  end

  def create
    vips = Plan.new vip_params

    if vips.save
      render json: {
        success: true,
        info: "创建vip成功!",
        vip: vips,
      }, status: 200
    elsif
      render json: {
        success: true,
        info: "创建vip失败",
      }, status: 403
    end

  end

  private

  def vip_params
    params.permit(:name, :may_release, :may_view, :may_set_top,
                                        :may_receive, :may_join_fairs, :status)
  end
end
