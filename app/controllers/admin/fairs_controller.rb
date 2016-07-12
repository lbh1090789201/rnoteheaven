class Admin::FairsController < AdminController
  before_action :require_fairs_manager!
  protect_from_forgery :except => [:create]

  def index
    @fairs = Fair.where(status: 'processing')
    p @fairs
    p '--------------'
  end

  def create
    fair = Fair.new(fair_params)

    if fair.save
      render js: 'window.location.replace(window.location.href);', status: 200
      # render json: {
      #   success: true,
      #   info: '新建专场成功！',
      #   fair: fair
      # }, status: 200
    else
      render json: '新建专场失败。', status: 403
    end
  end

  def history
  end

  private
    def fair_params
      params.permit(:name, :begin_at, :end_at, :creator, :intro, :status, :banner)
    end
end
