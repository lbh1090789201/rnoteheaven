class NotesController < ApplicationController
  before_action do
    @user_id = current_user.id if current_user
    authenticate_user!
    @title = "我的笔记"
  end

  def index
    if params[:index]
      articles = Note.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      get_notes_title(articles, "index")
    elsif params[:search]
      articles = Note.filter_by_title(params[:title]).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      get_notes_title(articles, "search")
    end
  end

  def phone_notes
    articles = Note.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    @total_pages = articles.total_pages
    @articles = []
    articles.each do |a|
      @articles.push Note.get_note_info(a)
    end
  end

  def show
    @article = Note.find params[:id].as_json
    render json: {
      success: true,
      article: @article
    }, status: 200
  end

  def create
    if params[:image]
      i = params[:length].to_i
      images = []
      i.times do |t|
        key = "file_" + t.to_s
        file = params[key]
        gallery = Gallery.create!({image: file})

        unless gallery
          render json: {
            success: false,
            info: "添加图片失败"
          }, status: 403
          return
        end
        images.push gallery.image.url
      end

      render json: {
        success: true,
        info: "添加图片成功",
        images: images
      }, status: 200
    end
  end

  def update
    if params[:id] == "0"
      note = Note.new(note_params)
      note.user_id = current_user.id
      note.author = current_user.show_name

      if note.save!
        article_id = note.id
        render json: {
          success: true,
          info: "创建笔记成功！",
          article_id: article_id
        }, status: 200
      end
    else
      note = Note.find params[:id]
      if note.update!(note_params)
        render json: {
          success: true,
          info: "更新笔记成功！",
        }, status: 200
      end
    end
  end

  private

  def note_params
    params.permit(:title, :content)
  end

  def get_notes_title(articles, come)
    @articles = {}
    @dates = []
    now_date = Time.now.strftime("%Y-%m")

    @articles[now_date] = []
    @dates.push now_date
    articles.each do |a|
      create_time = a.created_at.strftime("%Y-%m")
      if now_date == create_time
        @articles[now_date].push a.as_json
      else
        now_date = create_time
        @articles[now_date] = []
        @articles[now_date].push a.as_json
        @dates.push create_time
      end
    end
    @total_pages = articles.total_pages
    render json: {
      success: true,
      articles: @articles,
      dates: @dates,
      total_pages: @total_pages,
      c_page: params[:page],
      come: come
    }, status: 200
  end
end
