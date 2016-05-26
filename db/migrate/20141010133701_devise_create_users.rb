class DeviseCreateUsers < ActiveRecord::Migration

  def change
    create_table(:users) do |t|
      # merge user_info
      t.integer :start_work_at #工作年限
      t.string :location #所在区域
      t.string :seeking_job #是否求职
      t.string :highest_degree #最高学历
      t.string :birthday #出生年月


      # added for a basic user
      t.string :cellphone,         :null => false, :default => "" #电话
      t.string :avatar   #头像
      t.string :show_name,         :null => false #姓名

      ## token authenticatable
      t.string :provider, :null => false, :default => "email" #
      t.string :uid, :null => false, :default => "" #
      t.text :tokens #token

      ## Database authenticatable
      t.string :username,           :null => false, :default => ""
      t.string :email
      t.string :encrypted_password, :null => false, :default => ""

      ## Admin
      # t.boolean :admin, :null => false, :default => false

      ## Lock
      t.boolean :locked, :null => false, :default => false

      ## Friendly_id
      t.string :slug #

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable #电话

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.string :main_video #视频
      t.integer :sex #性别  0:女　１：男

      t.string :user_number #用户ID
      t.string :wechat_openid #微信id
      t.string :vcode #验证码
      t.string :update_vcode_time #生成验证码的时间
      t.string :transaction_password #交易密码
      t.string :longitude #实时经度
      t.string :latitude #实时纬度

      t.float :balance #余额
      t.float :total_consumption #消费累计

      t.string :user_type #用户类型  webapp/merchant/admin
      t.boolean :is_top, :null => false, :default => false #是否是置顶数据
      t.integer :merchant_id #用户是商家时对应的商家id

      t.timestamps null: false
    end

    #add_index :users, [:uid, :provider],     :unique => true
    add_index :users, :cellphone
    add_index :users, :username,             :unique => true
    #add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :slug,                 :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end
end
