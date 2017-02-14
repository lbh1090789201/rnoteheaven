class Note < ActiveRecord::Base
  belongs_to :user

  has_many :comment
  has_many :recommend

  # 按创作时间查询
  scope :filter_time_from, ->(time_from) {
    where("created_at >= ?", time_from) if time_from.present?
  }

  scope :filter_time_to, ->(time_to) {
    where("created_at < ?", time_to) if time_to.present?
  }

  # 按作者模糊查询
  scope :filter_by_author, ->(author) {
    where("author LIKE '%" + author + "%'") if author.present?
  }

  # 按文章名模糊查询
  scope :filter_by_title, ->(title) {
    where("title LIKE '%" + title + "%'") if title.present?
  }

  # 判断文章创作时间
  def self.get_create_time time
    hours = ((Time.now - time) / 1.hours).to_i + 1
    if hours <= 10
      now_hours = "大约" + hours.to_s + "小时之前"
    elsif hours > 10 && hours <= 24
      now_hours = "大约1天前"
    elsif hours > 24
      day = (hours / 24).to_i + 1
      now_hours = "大约" + day.to_s + "天之前"
    end
    return now_hours
  end

  # 首页数据拼接
  def self.get_note_info note
    note_create_time = Note.get_create_time note.created_at # 得到文章发布时间
    comment_number = Comment.where(note_id: note.id).size
    collect_number = FavoriteArticle.where(note_id: note.id).size
    recom_number = Recommend.where(note_id: note.id).size
    o = {}
    user = User.find note.user_id
    o["created_at"] = note_create_time
    o["show_name"] = user.show_name
    o["article"] = note.as_json
    o["comment_number"] = comment_number
    o["collect_number"] = collect_number
    o["recom_number"] = recom_number
    return o
  end
end
