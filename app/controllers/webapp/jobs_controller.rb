class Webapp::JobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
   def index
   end

   def show
     @job = Job.find_by_id(params[:id])
     is_applied = ApplyRecord.is_applied(current_user.id , params[:id])
     @has_resume = Resume.find_by_user_id current_user.id
     @btn_apply = {}
    #  if
   end

   # private
   # def job_params
   #   params.require(:job).permit(:name, :job_type, :salary_range, :location)
   # end
   private
   def btn_info
   end

end
