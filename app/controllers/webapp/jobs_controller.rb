class Webapp::JobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
   def index
   end

   def show
   end

   # private
   # def job_params
   #   params.require(:job).permit(:name, :job_type, :salary_range, :location)
   # end
  
end
