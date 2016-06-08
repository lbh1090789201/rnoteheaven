class Webapp::EducationExperiencesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    @education_experiences = EducationExperience.where(:user_id => current_user.id)
  end

  def new
    @education_experience = EducationExperience.new
  end

  def create
    education_experience = EducationExperience.new education_experience_params
    education_experience.user_id = current_user.id

    if education_experience.save
      flash.now[:notice] = "创建成功！"
      render js: ' history.go(-1);'
    else
      redirect_to :back, alert: "添加失败"
      return
    end
  end

  def edit
    @education_experience = EducationExperience.find_by_id params[:id]
    @education_experience.entry_at = Time.at(@education_experience.entry_at).utc.strftime("%H:%M:%S")
  end

  def update
    @education_experience = EducationExperience.find_by_id params[:id]

    if @education_experience.update(education_experience_params)
      render js: ' history.go(-1);', notice: '修改成功！'
    else
      redirect_to :back, alert("修改失败")
      return
    end
  end

  private
  def education_experience_params
    params.require(:education_experience).permit(:college, :education_degree, :major, :entry_at, :graduated_at)
  end

end
