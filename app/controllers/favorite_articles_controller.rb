class FavoriteArticlesController < ApplicationController
  before_action do
    @user_id = current_user.id if current_user
    authenticate_user!
    @title = "收藏库"
  end

  def index
    articles = Note.where(user_id: 1).order("created_at DESC")
    @articles = []
    articles.each do |a|
      @articles.push Note.get_note_info(a)
    end
  end

  def create
    favorite_article = FavoriteArticle.find_by(user_id: current_user.id, note_id: params[:note_id])
    unless favorite_article.nil?
      render json: {
        success: false,
        info: "你已收藏过该文章"
      }, status: 403
      return
    end
    favorite_article = FavoriteArticle.create!(note_id: params[:note_id])
    favorite_article.user_id = current_user.id
    if favorite_article.save!
      render json: {
        success: true,
        info: "收藏成功"
      }, status: 200
    end
  end
end
