class Admin::FairsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create, :update]

  def index
    if params[:search]
      fairs = Fair.filter_by_status(params[:status])
                   .filter_begain_at(params[:time_from])
                   .filter_end_at(params[:time_to])
                   .filter_by_name(params[:name])

      @fairs = Fair.get_info fairs
      render json: {
        success: true,
        info: '搜索专场成功！',
        fairs: @fairs
      }, status: 200
    else
      fairs = Fair.where(status: ['processing', 'pause'])
      fairs = Fair.is_end fairs
      @fairs = Fair.get_info fairs
    end
  end

  def create
    fair = Fair.new(fair_params)

    if fair.save

      EventLog.create_log current_user.id, current_user.show_name, 'Fair', fair.id, "专场", '新建'
      render json: {
        success: true,
        info: '新建专场成功！',
        fair: fair
      }, status: 200
    else
      render json: '新建专场失败。', status: 403
    end
  end

  def update
    fair = Fair.find params[:id]
    fair.update! fair_params

    if fair.status == "end"
      fair = Fair.set_end fair
    end

    EventLog.create_log current_user.id, current_user.show_name, 'Fair', fair.id, "专场", '更新'
    fair = Fair.fair_statistic fair
    
    render json: {
      success: true,
      info: '更新专场成功',
      fair: fair
    }, status: 200
  end

  def history
    @fairs = Fair.filter_by_status 'end'
  end

  private
    def fair_params
      params.permit(:name, :begain_at, :end_at, :creator, :intro, :status, :banner)
    end
end
