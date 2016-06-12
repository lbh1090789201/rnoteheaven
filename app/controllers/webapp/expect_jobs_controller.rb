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

  def new
  end

  def update
    @expect_job = ExpectJob.find_by_id params[:id]
    if @expect_job.update(expect_job_params)
      render js: 'history.go(-1);'
    else
      redirect_to :back, alert("修改失败")
    end
  end

  private
  def expect_job_params
    params.require(:expect_job).permit(:name, :job_type, :location, :expected_salary_range, :job_desc)
  end
end
