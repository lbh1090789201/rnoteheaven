class RecommendsController < ApplicationController
  before_action do
    authenticate_user!
  end

  def create
    recommends = Recommend.find_by(user_id: current_user.id, note_id: params[:note_id])
    unless recommends.nil?
      render json: {
        success: false,
        info: "你已推荐过该文章"
      }, status: 403
      return
    end
    recommend = Recommend.new(note_id: params[:note_id])
    recommend.recom_amount = 1
    recommend.user_id = current_user.id
    if recommend.save!
      recom_number = Recommend.where(note_id: params[:note_id]).size
      render json: {
        success: true,
        info: "推荐成功",
        recom_number: recom_number
      }, status: 200
    end
  end
end
