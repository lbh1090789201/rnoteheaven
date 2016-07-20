class Admin::VipsController < AdminController
  before_action :require_vips_manager!
    # set_vip = Employer.set_vip current_user.id, 1
    protect_from_forgery :except => [:index, :create, :update, :destroy]

  def index
    @vips = Plan.all

    if params[:search]
      @vvs = Plan.filter_by_status(params[:status]).filter_by_name(params[:vip_name])

      render json: {
        success: true,
        info: "搜索成功",
        vip: @vvs
      }, status: 200
    end
  end

  def create
    vips = Plan.new vip_params

    if vips.save
      EventLog.create_log current_user.id, current_user.show_name, 'Plan', vips.id, "套餐", '新建'

      render json: {
        success: true,
        info: "创建vip成功!",
        vip: vips,
      }, status: 200
    elsif
      render json: {
        success: false,
        info: "创建vip失败",
      }, status: 403
    end

  end

  def update
    vip = Plan.find params[:id]

    if vip.update vip_params
      EventLog.create_log current_user.id, current_user.show_name, 'Plan', vip.id, "套餐", '更新'
      
      render json: {
        success: true,
        info: "更新成功",
        vip: vip
      }, status: 200
    else
      render json: {
        success: false,
        info: "更新失败"
      }, status: 403
    end
  end

  def destroy
      vip = Plan.find params[:id]

      if vip.destroy
        EventLog.create_log current_user.id, current_user.show_name, 'Plan', vip.id, "套餐", '删除'

        render json: {
          success: true,
          info: "删除成功！"
        }, status: 200
      else
        render json: {
          success: false,
          indo: "删除失败"
        }, status: 403
      end
  end

  private

  def vip_params
    params.permit(:name, :may_release, :may_view, :may_set_top,
                                        :may_receive, :may_join_fairs, :status)
  end
end
