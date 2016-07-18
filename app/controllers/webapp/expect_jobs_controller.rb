class Webapp::ExpectJobsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
  end

  def edit
    @expect_job = ExpectJob.where(user_id: current_user.id).first_or_create!
  end

  def show
    @expect_job = ExpectJob.find_by_user_id current_user.id
  end


  def update
    @expect_job = ExpectJob.find_by_id params[:id]
    if @expect_job.update(expect_job_params)
      # 更新简历完整度
      resume_maturity = Resume.get_maturity current_user.id

      render js: 'location.href = document.referrer'
    else
      redirect_to :back, alert("修改失败")
    end
  end

  def destroy
    @expect_job = ExpectJob.find(params[:id])
    if @expect_job.destroy
      redirect_to webapp_work_experiences_path, alert:"用户删除成功！"
    else
      redirect_to :back, alert:"删除失败，请重新操作！"
    end
  end

  private
  def expect_job_params
    params.require(:expect_job).permit(:name, :job_type, :location, :expected_salary_range, :job_desc)
  end
end
