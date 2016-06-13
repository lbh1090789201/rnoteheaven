class Webapp::ResumesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  protect_from_forgery except: :update

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
    @user.avatar? ? @avatar = @user.avatar_url : "avator.png"
  end

  def show
    resume = Resume.where(user_id: current_user.id).first_or_create!

    @user = User.find_by_id(current_user.id)
    @work_experiences = WorkExperience.where(:user_id => @user.id)
    @education_experiences = EducationExperience.where(:user_id => @user.id).order(updated_at: :desc)
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @user.avatar? ? @avatar = @user.avatar_url : "avator.png"
    @refresh_left = Resume.refresh_left(resume.id)
  end

  def update
    if params[:refresh]
      resume = Resume.find params[:id]
      resume.refresh_at = Time.now

      if resume.save
        render json: {
          success: true,
          info: "简历刷新成功"
        },status: 200
      else
        render json: {
                   success: false,
                   info: '简历刷新失败'
               }, status: 403
      end
    end
  end

  def edit
    if params[:val] == 'basic'
      # render partial: "edit_basic", layout: "header"
      # @val = 'basic'
    end
  end
end
