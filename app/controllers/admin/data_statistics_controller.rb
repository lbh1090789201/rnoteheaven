class Admin::DataStatisticsController < AdminController
  def index
    if !params[:resume_deliver].blank?
      p "111111111111111"
    end
  end
end
