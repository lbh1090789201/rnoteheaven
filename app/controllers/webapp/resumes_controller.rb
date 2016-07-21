class Webapp::ResumesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: :update
  layout false, only: [:index]

  def index
  end

  def create
  end

  def new

  end

  def destroy
  end

  def preview
    resume = Resume.where(user_id: current_user.id).first_or_create!

    @user = User.find_by_id(current_user.id)
    @work_experiences = WorkExperience.where(:user_id => @user.id)
    @education_experiences = EducationExperience.where(:user_id => @user.id)
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @user.avatar_url.blank? ? @avatar = "avator2.png" : @avatar = @user.avatar_url
    @certificates = Certificate.where(:user_id => @user.id)
  end

  def show
    resume = Resume.where(user_id: current_user.id).first_or_create!

    @user = User.find_by_id(current_user.id)
    @work_experiences = WorkExperience.where(:user_id => @user.id).order('started_at DESC')
    @education_experiences = EducationExperience.where(:user_id => @user.id).order('graduated_at DESC')
    expect_job = ExpectJob.where(user_id: current_user.id).first_or_create!
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @certificates = Certificate.where user_id: current_user.id
    @user.avatar_url.blank? ? @avatar = "avator.png" : @avatar = @user.avatar_url
    @refresh_left = Resume.refresh_left(resume.id)
  end

  def update
    if params[:refresh]
      resume = Resume.find params[:id]
      resume.refresh_at = Time.now

      if resume.save
        render js: 'location.href = document.referrer'
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

end
