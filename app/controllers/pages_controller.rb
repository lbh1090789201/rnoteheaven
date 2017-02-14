class PagesController < ApplicationController
  before_action do
    @user_id = current_user.id if current_user
    authenticate_user! if current_user
    @title = "首页"
  end

  def index
    if params[:search]
      time_from = params[:time_from].blank? ? "" : params[:time_from].to_time.beginning_of_day
      time_to = params[:time_to].blank? ? "" : params[:time_to].to_time.end_of_day

      articles = Note.filter_time_from(time_from)
                      .filter_time_to(time_to)
                      .filter_by_title(params[:title])
                      .filter_by_author(params[:author])
                      .paginate(page: params[:page], per_page: 10)
      @articles = []
      articles.each do |a|
        article = Note.get_note_info a
        @articles.push article
      end

      render json: {
        success: true,
        info: '搜索成功',
        articles: @articles,
        total_pages: articles.total_pages,
        current_page: params[:page].nil? ? "1" : params[:page]
      }, status: 200
      return;
    elsif params[:come]
      if params[:come] == "new"
        articles = Note.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
      else
        articles = Note.all.order("amount DESC").paginate(page: params[:page], per_page: 10)
      end
      render json: {
        success: true,
        info: '搜索成功',
        articles: get_articles_info(articles),
        total_pages: articles.total_pages,
        current_page: params[:page].nil? ? "1" : params[:page]
      }, status: 200
      return;
    else
      # 最新
      new_articles = Note.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
      @new_articles = get_articles_info new_articles
      @new_total_pages = new_articles.total_pages

      # 最热
      hot_articles = Note.all.order("amount DESC").paginate(page: params[:page], per_page: 10)
      @hot_articles = get_articles_info hot_articles
      @hot_total_pages = hot_articles.total_pages
    end
  end

  def show
    article = Note.find params[:id]
    o = Note.get_note_info article

    render json: {
      success: true,
      info: '查询成功！',
      article: o,
    }, status: 200
  end

  private

  def get_articles_info articles
    articles_arr = []
    articles.each do |a|
      article = Note.get_note_info a
      articles_arr.push article
    end
    return articles_arr
  end
end
