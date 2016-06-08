class Webapp::WorkExperiencesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    @work_experiences = WorkExperience.where(:user_id => current_user.id)
    # puts "........."+@work_experiences.to_json.to_s
  end

  def new
    @work_experience = WorkExperience.new
  end

  def create
    user = User.find_by_id(current_user.id)
    work_experiences = user.work_experiences.build(work_experience_params)

    if work_experiences.save
      render js: ' history.go(-1);', notice: '创建成功！'
    else
      redirect_to :back, alert: "添加失败"
      return
    end
  end

  def show

  end

  def edit
      @work_experience = WorkExperience.find params[:id]
  end

  def update
    @work_experience = WorkExperience.find params[:id]
    if @work_experience.update(work_experience_params)
      redirect_to webapp_resume_path(current_user.id), notice: "修改成功"
      return
    else
      redirect_to :back, alert: "修改失败"
      return
    end
  end

  def destroy
  end

  private

  def work_experience_params
    params.require(:work_experience).permit(:company, :position, :started_at, :left_time, :job_desc)
  end
end
