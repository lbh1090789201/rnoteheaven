class Webapp::TrainingExperiencesController < ApplicationController
    before_action :authenticate_user!   # 登陆验证

    def index
      @training_experiences = TrainingExperience.where(user_id: current_user.id).order('started_at DESC')
      @resume = Resume.find_by user_id: current_user.id
    end

    def new
      @training_experience = TrainingExperience.new
    end

    def create
      training_experience = TrainingExperience.new training_experience_params
      training_experience.user_id = current_user.id

      if training_experience.save
        render js: "location.href = document.referrer"
      else
        redirect_to :back, alert: "添加失败"
        return
      end
    end

    def edit
      @training_experience = TrainingExperience.find params[:id]
      @training_experience.started_at = @training_experience.started_at.strftime('%Y-%m-%d') if @training_experience.started_at.present?
      @training_experience.ended_at = @training_experience.ended_at.strftime('%Y-%m-%d') if @training_experience.ended_at.present?
    end

    def update
      training_experience = TrainingExperience.find params[:id]

      if training_experience.update! training_experience_params
        render js: 'location.href = document.referrer'
      else
        redirect_to :back, alert: '修改失败'
        return
      end
    end

    def destroy
      training_experience = TrainingExperience.find params[:id]

      if training_experience.destroy
        render js: 'location.href = document.referrer'
      else
        redirect_to :back, alert: '删除失败'
        return
      end
    end

    private

    def training_experience_params
      params.permit(:name, :started_at, :ended_at, :desc, :certificate)
    end
end
