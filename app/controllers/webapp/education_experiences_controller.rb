class Webapp::EducationExperiencesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  
  def show
    @education_experiences = EducationExperience.all
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
