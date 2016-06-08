class Webapp::JobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
   def index
   end

   def show
     @job = Job.find_by_id(params[:id])
     is_applied = ApplyRecord.is_applied(current_user.id , params[:id])
     has_resume = Resume.find_by_user_id current_user.id
     @btn_apply = btn_info(is_applied, has_resume)
   end

   # private
   # def job_params
   #   params.require(:job).permit(:name, :job_type, :salary_range, :location)
   # end
   private
   #根据情况回传按钮状态
   def btn_info(is_applied, has_resume)
     if is_applied
       return {css: 'is_applied', text: '已应聘'}
     else
       if has_resume
         return {css: 'no_applied', text: '应聘职位'}
       else
         return {css: 'no_resume', text: '应聘职位'}
       end
     end
   end

end
