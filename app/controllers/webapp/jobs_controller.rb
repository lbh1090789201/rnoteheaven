class Webapp::JobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
   def index
   end

   def show
     @job = Job.find_by_id(params[:id])
     @is_applied = ApplyRecord.is_applied(current_user.id , params[:id])
   end

   # private
   # def job_params
   #   params.require(:job).permit(:name, :job_type, :salary_range, :location)
   # end

end
