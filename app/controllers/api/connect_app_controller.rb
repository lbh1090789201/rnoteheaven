require 'rest-client'

class Api::ConnectAppController < ApiController
  # before_action :require_employer!   # 登陆验证
  # before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:login_app]

  def login_app
    @res = RestClient.post "http://119.97.224.253:9014/HealthComm/modelToken/getToken",
                           {
                             userId: login_params[:userId],
                             target: login_params[:target],
                             lgParam: {
                               session: login_params[:session],
                               seq: login_params[:seq]
                             }
                           }.to_json, :content_type => :json, :accept => :json
    @res = JSON.parse(@res)

    if @res["responseCode"] == "200"
      new_user @res["token"]
    end
  end

  def index
    user = User.find_by user_number: params[:userId]

    if user
      sign_in(user)
      if user.user_type == "copper"
        redirect_to webapp_home_path
      elsif user.user_type == "gold"
        redirect_to employer_resumes_path
      end
    else
      new_user params[:token]
    end
  end


  private
    def login_params
      params.permit(:userId, :target, :session, :seq)
    end

    def new_user token
      @user_info = RestClient.post "http://119.97.224.253:9014/HealthComm/modelToken/accreditLogin",
                                    {
                                      token: token
                                    }.to_json, :content_type => :json, :accept => :json
      @user_info = JSON.parse(@user_info)
      p @user_info
      p '-------------------'
      if @user_info["responseCode"] == "200"
        auto_login @user_info["userInfo"]
      else
        render json: @user_info, status: 500
      end
    end

    def auto_login user_info
      if user_info["uaid"].present?
        user = User.find_by user_number: user_info["uaid"]
        if user
          sign_in(user)
          render json: {
              success: true,
              info: '自动登陆成功',
              url: root_url + "/webapp/home"
            }, status: 200
          # redirect_to webapp_home_path
        else
          sign_up_copper user_info
        end

      elsif user_info["entid"].present?
        user = User.find_by user_number: user_info["entid"]
        if user
          sign_in(user)
          render json: {
              success: true,
              info: '自动登陆成功',
              url: root_url + "/employer/resumes"
            }, status: 200
          # redirect_to employer_resumes_path
        else
          sign_up_gold user_info
        end

      else
        render json: '服务器参数错误', status: 500
      end
    end

    def sign_up_copper user_info
      new_copper = {
        user_number: user_info["uaid"],
        user_type: "copper",
        sex: user_info["gender"],
        username: "copper" + user_info["uaid"].to_s,
        password: "123456",
        show_name: user_info["realName"],
        cellphone: user_info["telephone"],
        email: "copper" + user_info["uaid"].to_s + "@example.com"
      }

      user = User.create! new_copper
      user.add_role :copper

      sign_in(user)
      render json: {
          success: true,
          info: '注册并登陆成功',
          url: root_url + "/webapp/home"
        }, status: 200
    end

    def sign_up_gold user_info
      new_gold = {
        user_number: user_info["entid"],
        user_type: "gold",
        username: "gold" + user_info["entid"].to_s,
        password: "123456",
        show_name: user_info["entname"],
        email: "copper" + user_info["uaid"].to_s + "@example.com"
      }
      user = User.create! new_gold
      user.add_role :gold

      new_hospital = {
        name: user_info["entname"],
        location: user_info["entaddress"],
        introduction: user_info["entname"] + "的医院介绍"
      }
      hospital = Hospital.create! new_hospital

      new_employer = {
        user_id: user.id,
        hospital_id: hospital.id
      }
      employer = Employer.create! new_employer
      set_vip = Employer.set_vip user.id, 1

      sign_in(user)
      render json: {
          success: true,
          info: '注册并登陆成功',
          url: root_url + "/employer/resumes"
        }, status: 200
    end

end
