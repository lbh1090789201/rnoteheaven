include ValidationCodesHelper
include BdLbsHelper
include UsersHelper
module Api
  class UsersController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #创建用户
    def create
      user = User.new(
          :wechat_openid => params[:wechat_openid],
          :username => params[:cellphone],
          :show_name => params[:show_name],
          :email => params[:show_name]+ "@qq.com" ,
          :cellphone => params[:cellphone],
          :password => "123456",
          :password_confirmation => "123456",
      )
      if params[:avatar] != nil
        user.avatar = params[:avatar]
      end

      if params[:latitude] !=nil && params[:longitude] != nil
        longitude = params[:longitude]
        latitude = params[:latitude]
      else
        longitude = $shenzhen_center_longitude
        latitude = $shenzhen_center_latitude
      end

      user.longitude = longitude
      user.latitude = latitude

      sex = 0
      if params[:sex] != nil
        user.sex = params[:sex]
        sex = params[:sex]
      end

      if params[:main_video] != nil
        user.main_video = params[:main_video]
      end

      user.user_number = generate_user_number_code()
      user.balance = 0
      user.total_consumption = 0
      puts user.to_json.to_s
      unless user.save
        puts '创建用户失败'
        render json: {
                   success: false,
                   errors: ['创建用户失败'],
               }, status: 403
        return
      end

      userInfo = UserInfo.new
      userInfo.user_id = user.id

      userInfo.save

      u = {
          id: user.id,
          show_name: user.show_name,
          latitude: user.latitude,
          longitude: user.longitude,
          sex: sex
      }

      puts '---------------------------u: ' + u.to_json.to_s

      create_user_on_lbs(u)

      render json: {
                 success: true,
                 info: '创建用户成功',
                 data: user
             }, status: 200
    end

    #修改用户信息
    def update
      user = User.find_by(id: params[:id])
      unless user
        render json: {
                   success: false,
                   info: '修改用户信息失败'
               }, status: 403
        return
      end

      msg = nil

      if params[:cellphone] && :params[:vcode]
        #修改用户信息－－绑定手机号cellphone
        unless ValidationCode.verify_vcode_effective? params[:cellphone], :params[:vcode]
          render json: {
                     success:false,
                     info:'验证码错误'
                 }, status: 403
          return
        end
        user.cellphone = params[:cellphone]
        msg = '绑定手机号'
      end
      if params[:transaction_password]
        #修改用户信息－－设置/修改支付密码
        user.transaction_password = params[:transaction_password]
        msg = '绑定支付密码'
      end
      if params[:avatar]
        #修改用户信息－－上传/修改头像
        user.avatar = params[:avatar]
        msg = '上传头像'
      end
      if params[:cellphone] && params[:send_vcode]
        #修改用户信息－－获取验证码vcode
        validation_code_params = {cellphone: params[:cellphone]}
        create_vcode(validation_code_params)
        return
      end

      need_update_lbs = false
      if params[:longitude] && params[:latitude]
        if user.longitude != params[:longitude] || user.latitude != params[:latitude]
          need_update_lbs = true
          user.longitude = params[:longitude]
          user.latitude = params[:latitude]
        end
      end

      if params[:sex] != nil && params[:sex].to_s != user.sex.to_s
        need_update_lbs = true
        user.sex = params[:sex].to_i
      end

      unless user.update
        render json: {
                   success: false,
                   info: msg + '失败'
               }, status: 403
        return
      end

      if need_update_lbs
        u = {
            id: user.id,
            show_name: user.show_name,
            latitude: user.latitude,
            longitude: user.longitude,
            sex: user.sex
        }
        update_user_on_lbs(u)
      end

      render json: {
                 success: true,
                 info: msg + '成功',
                 data: user
             }, status: 200
    end

    def destroy
      user = User.find_by(id: params[:id])
      puts 'user => ' + user.to_json.to_s
      unless user
        render json: {
                   success: false,
                   info: '删除用户信息失败'
               }, status: 403
        return
      end
      if user.delete
        render json: {
                   success: true,
                   info: '删除用户信息成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '删除用户信息失败'
             }, status: 403
    end

    #获取用户列表
    def index
      if params[:lng] != nil && params[:lat] != nil
        #待修改
        users = User.all
      else
        #待修改
        #深圳市的用户
        users = User.all
      end
      puts 'users => ' + users.to_json.to_s
      unless users
        render json: {
                   success: false,
                   info: '获取用户信息列表失败'
               }, status: 403
        return
      end
      fs = []
      users.each do |user|
        user_info = UserInfo.find_by(user_id: user[:id])
        f = {
            id: user.id,
            show_name: user.show_name,#微信用户不可修改
            cellphone: user.cellphone,
            sex: user.sex,
            main_video: user.main_video,
            avatar: user.avatar,
            user_number: user.user_number,#注册时自动生成
            wechat_openid: user.wechat_openid,#微信用户不可修改
            vcode: user.vcode,
            update_vcode_time: user.update_vcode_time,
            encrypted_password: user.encrypted_password,#微信用户没有此信息
            transaction_password: user.transaction_password,
            balance: user.balance,
            total_consumption: user.total_consumption,#注册时初始化
            longitude: user.longitude,
            latitude: user.latitude,
            user_info:user_info
        }
        fs.push(f)
      end
      render json: {
                 success: true,
                 info: '获取用户信息列表成功',
                 data: fs
             }, status: 200
    end

    #获取详情
    def show
      user = User.find_by(id: params[:id])
      puts 'user => ' + user.to_json.to_s
      unless user
        render json: {
                   success: false,
                   info: '获取用户信息详情失败'
               }, status: 200
        return
      end
      user_info = UserInfo.find_by(user_id: user[:id])
      f = {
          id: user.id,
          show_name: user.show_name,#微信用户不可修改
          cellphone: user.cellphone,
          sex: user.sex,
          main_video: user.main_video,
          avatar: user.avatar,
          user_number: user.user_number,#注册时自动生成
          wechat_openid: user.wechat_openid,#微信用户不可修改
          vcode: user.vcode,
          update_vcode_time: user.update_vcode_time,
          encrypted_password: user.encrypted_password,#微信用户没有此信息
          transaction_password: user.transaction_password,
          balance: user.balance,
          total_consumption: user.total_consumption,#注册时初始化
          longitude: user.longitude,
          latitude: user.latitude,
          user_info:user_info
      }
      render json: {
                 success: true,
                 info: '获取用户信息详情成功',
                 data: f
             }, status: 403
    end

    private
    def user_params
      params.permit(:show_name,#微信用户不可修改
                    :cellphone, :avatar,
                    :user_number,#注册时自动生成
                    :wechat_openid,#微信用户不可修改
                    :vcode, :update_vcode_time,
                    :encrypted_password,#微信用户没有此信息
                    :transaction_password,
                    :balance,  :total_consumption,#注册时初始化
                    :longitude, :latitude)

      # t.string :cellphone,         :null => false, :default => "" #电话
      # t.string :avatar   #头像
      # t.string :show_name,         :null => false #昵称
      # t.string :user_number #用户ID
      # t.string :wechat_openid #微信id
      # t.string :vcode #验证码
      # t.string :update_vcode_time #生成验证码的时间：
      # t.string :encrypted_password, :null => false, :default => "" 加密密码
      # t.float :balance #余额
      # t.string :transaction_password #交易密码
      # t.string :longitude #实时经度
      # t.string :latitude #实时纬度
      # t.float :total_consumption #消费累计

    end
  end
end
