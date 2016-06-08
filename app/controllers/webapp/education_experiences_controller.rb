class Webapp::EducationExperiencesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  
  def index
    @education_experiences = EducationExperience.where(:user_id => current_user.id)
    puts "........."+@education_experience.to_json.to_s
  end

  def new
    @education_experience = EducationExperience.new
  end

  def create
    user = User.find_by_id(current_user.id)
    education_experiences = user.education_experiences.build(education_experience_params)

    if education_experiences.save
      redirect_to webapp_resume_path(current_user.id), notice: "添加成功"
      return
    else
      redirect_to :back, alert: "添加失败"
      return
    end
  end

  def edit
    @education_experience = EducationExperience.find_by_id params[:id]
  end

  def update
    @education_experience = EducationExperience.find_by_id params[:id]
    puts "........."+@education_experience.to_json.to_s
    if @education_experience.update(education_experience_params)
      redirect_to webapp_resume_path(current_user.id), notice: "修改成功"
      return
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
