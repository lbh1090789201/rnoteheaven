class Webapp::WorkExperiencesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: :destroy

  def index
    @work_experiences = WorkExperience.where(:user_id => current_user.id).order('started_at DESC')
    @resume = Resume.find_by user_id: current_user.id
  end

  def new
    @work_experience = WorkExperience.new
  end

  def create
    user = User.find_by_id(current_user.id)
    work_experiences = user.work_experiences.build(work_experience_params)

    if work_experiences.save
      render js: 'location.href = document.referrer'
    else
      redirect_to :back, alert: "添加失败"
      return
    end
  end

  def edit
      @work_experience = WorkExperience.find params[:id]
      @work_experience.started_at = @work_experience.started_at.strftime('%Y-%m-%d') if @work_experience.started_at
      @work_experience.left_time = @work_experience.left_time.strftime('%Y-%m-%d') if @work_experience.left_time
  end

  def update
    @work_experience = WorkExperience.find params[:id]
    if @work_experience.update(work_experience_params)
      render js: 'location.href=document.referrer'
    else
      redirect_to :back, alert: "修改失败"
      return
    end
  end

  def destroy
    @work_experience = WorkExperience.find(params[:id])
    if @work_experience.destroy
      render js: 'location.href=document.referrer'
    else
      redirect_to :back, alert:"删除失败，请重新操作！"
    end
  end

  private

  def work_experience_params
    params.permit(:company, :position, :started_at, :left_time, :job_desc)
  end
end
