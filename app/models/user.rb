class User < ActiveRecord::Base #用户
  rolify
  # resourcify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          #:confirmable,
         :omniauthable
  include DeviseTokenAuth::Concerns::User

  # Use friendly_id on Users
  extend FriendlyId
  friendly_id :friendify, use: :slugged
  mount_uploader :avatar, AvatarUploader
  # mount_uploader :main_video, AlbumnUploader


  # for user_albumns
  has_many :user_albumns
  has_many :resumes
  has_many :favorite_jobs
  has_many :work_experiences

  # necessary to override friendly_id reserved words
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "{username}"
    end
  end




  # Pagination
  paginates_per 100

  # Validations
  # :username
  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: "can only contain letters and digits"
  validates :username, length: { in: 4..45 }
  # :email
  #validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # t.string :cellphone,         :null => false, :default => "" #电话
  # t.string :avatar   #头像
  # t.string :show_name,         :null => false #昵称
  # t.string :user_number #用户ID
  # t.string :wechat_openid #微信id
  # t.string :vcode #验证码
  # t.string :update_vcode_time #生成验证码的时间：
  # t.string :encrypted_password, :null => false, :default => "" 加密密码

  # t.string :main_video #视频
  # t.integer :sex #性别  0:女　１：男

  # t.string :transaction_password #交易密码

  # t.float :balance #余额
  # t.float :total_consumption #消费累计

  # t.string :longitude #实时经度
  # t.string :latitude #实时纬度

  # t.string :user_type #用户类型  webapp/merchant/admin
  # t.boolean :is_top, :null => false, :default => false #是否是置顶数据
  # t.integer :merchant_id #用户是商家时对应的商家id

  def self.paged(page_number)
    #order(admin: :desc, username: :asc).page page_number
    order(username: :asc).page page_number
    order(username: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      #admin: :desc, username: :asc
      username: :asc
      ).page page_number
    else
      #order(admin: :desc, username: :asc).page page_number
      order(username: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","username","slug","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","username","slug","last_sign_in_at")
  end

  #获取User基本信息 bobo
  def self.get_user_main(user_id)
    user = User.select(:id, :show_name, :sex, :highest_degree,:start_work_at, :birthday,
                                :location, :cellphone, :email,  :seeking_job).find_by_id(user_id)
  end

  #判断是否填过简历
  def self.highest_degree(user_id)
    !User.find_by_id(user_id)[:highest_degree].nil?
  end



  def admin?
    false
  end


  def email_required?
    false
  end




end
