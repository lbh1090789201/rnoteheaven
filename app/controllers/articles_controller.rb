class ArticlesController < ApplicationController
  before_action do
    @user_id = current_user.id if current_user
    authenticate_user! if current_user
    @title = "首页"
  end

  def show
    @article = Note.find params[:id]
    @user = User.find @article.user_id
    @user_avatar = @user.avatar_url ? @user.avatar_url : "avator.png"

    comments = Comment.where(note_id: params[:id])
    @comment = []
    comments.each do |c|
      user = User.find c.user_id
      user_avatar = user.avatar_url ? user.avatar_url : "avator.png"
      o = {
        comment: c,
        avatar: user_avatar,
        show_name: user.show_name
      }
      @comment.push o
    end
  end

  def recom_articles
    notes = Note.all
    @recom_articles = []
    notes.each do |n|
      o = []
      recommends = Recommend.where(note_id: n.id)
      o.push recommends.size
      o.push n.title
      o.push n.id
      @recom_articles.push o
    end
    render json: {
      success: true,
      info: "获取热门推荐数据成功",
      recom_articles: @recom_articles
    }, status: 200
  end

  def create
    if params[:amount]
      note = Note.find params[:id]
      number = note.amount + 1
      note.amount = number
      note.save!

      render json: {
        success: true,
        info: "更新阅读量成功"
      }, status: 200
    end
  end
end
