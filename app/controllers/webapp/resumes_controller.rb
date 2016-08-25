class Webapp::ResumesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: :update

  def index
    url = after_sign_in_path_for(current_user)
    redirect_to url
  end

  def preview
    resume = Resume.where(user_id: current_user.id).first_or_create!

    @user = User.find_by_id(current_user.id)
    @work_experiences = WorkExperience.where(:user_id => @user.id).order('started_at DESC')
    @education_experiences = EducationExperience.where(:user_id => @user.id).order('graduated_at DESC')
    @training_experiences = TrainingExperience.where(:user_id => @user.id).order('started_at DESC')
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @user.avatar_url.blank? ? @avatar = "avator2.png" : @avatar = @user.avatar_url(:square)
    @certificates = Certificate.where(:user_id => @user.id)
  end

  def show
    resume = Resume.where(user_id: current_user.id).first_or_create!

    @user = User.find_by_id(current_user.id)
    @work_experiences = WorkExperience.where(:user_id => @user.id).order('started_at DESC')
    @education_experiences = EducationExperience.where(:user_id => @user.id).order('graduated_at DESC')
    @training_experiences = TrainingExperience.where(:user_id => @user.id).order('started_at DESC')
    expect_job = ExpectJob.where(user_id: current_user.id).first_or_create!
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @certificates = Certificate.where user_id: current_user.id
    @user.avatar_url.blank? ? @avatar = "avator.png" : @avatar = @user.avatar_url(:square)
    @refresh_left = Resume.refresh_left(resume.id)
  end

  def update
    if params[:refresh]
      resume = Resume.find params[:id]
      resume.refresh_at = Time.now

      if resume.save
        render json: {
                   success: true,
                   info: '简历刷新成功'
               }, status: 200
      else
        render json: {
                   success: false,
                   info: '简历刷新失败'
               }, status: 403
      end
    end

    if params[:resume_public]
      resume = Resume.find params[:id]
      resume.public = params[:resume_public]

      if resume.save
        render json: {
          success: true,
          info: "更改简历隐私成功！",
        }, status: 200
      else
        render json: {
          success: true,
          info: "更改简历隐私失败",
        }, status: 403
      end
    end
  end

  private
  def after_sign_in_path_for(resource)
    return unless resource
    return "/employer/resumes" if resource.has_role? :gold
    return "/admin/jobs/check" if (resource.admin? || resource.jobs_manager?)
    return "/admin/resumes/" if resource.resumes_manager?
    return "/admin/users/" if resource.acounts_manager?
    return "/webapp/home/"
  end

end
