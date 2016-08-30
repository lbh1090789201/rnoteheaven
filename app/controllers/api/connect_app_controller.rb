require 'rest-client'

class Api::ConnectAppController < ApiController
  # before_action :require_employer!   # 登陆验证
  # before_action :authenticate_user!   # 登陆验证
  protect_from_forgery :except => [:login_app, :get_hospital]

  def login_app
    @res = RestClient.post "#{$auto_token_url}/HealthComm/modelToken/getToken",
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
    p "66666666666666666"
    user = User.find_by user_number: params[:userId]
p "555555555555555555"
    if user
      # 校检用户
      user = Role.checkUser user
      sign_in(user)

      if user.user_type == "copper"
        redirect_to copper_home # 查看底部
      elsif user.user_type == "gold"
        redirect_to employer_resumes_path
      end
    else
      p "444444444444444"
      new_user params[:token]
    end
  end

  def get_hospital
    hospital = Hospital.select(:id, :name, :location, :contact_person)
                       .find_by contact_number: params[:telephone]

    if hospital.nil?
      render json: {
        success: false,
        info: '非医院负责人。'
      }, status: 200
    else
      hospital_info = hospital
      render json: {
        success: true,
        info: '获取医院信息成功！',
        hospital: hospital_info
      }, status: 200
    end
  end


  private
    def login_params
      params.permit(:userId, :target, :session, :seq)
    end

    def new_user token
      p "111111111111"
      @user_info = RestClient.post "#{$auto_token_url}/HealthComm/modelToken/accreditLogin",
                                    {
                                      token: token
                                    }.to_json, :content_type => :json, :accept => :json
      p "2222222222222222"
      @user_info = JSON.parse(@user_info)
      if @user_info["responseCode"] == "200"
        auto_login @user_info["userInfo"]
      else
        render json: @user_info, status: 500
      end
    end

    def auto_login user_info
      hospital = Hospital.find_by contact_number: user_info["telephone"]

      if hospital.present?
        sign_up_gold user_info, hospital
      else
        sign_up_copper user_info
      end
    end

    def sign_up_copper user_info
      new_copper = {
        user_number: user_info["uaid"],
        user_type: "copper",
        sex: user_info["gender"],
        username: "copper" + user_info["uaid"].to_s,
        password: "123456",
        show_name: user_info["realName"].present? ? user_info["realName"] : '',
        cellphone: user_info["telephone"],
        email: "copper" + user_info["uaid"].to_s + "@example.com"
      }

      user = User.create! new_copper
      user.add_role :copper

      sign_in(user)

      to_url = params[:to] == 'fair' ? webapp_job_fairs_path : "/webapp/home?lat=#{params[:lat]}&lng=#{params[:lng]}"
      redirect_to to_url
    end

    def sign_up_gold user_info, hospital
      new_gold = {
        user_number: user_info["uaid"],
        user_type: "gold",
        username: "gold" + user_info["uaid"].to_s,
        password: "123456",
        show_name: user_info["realName"].present? ? user_info["realName"] : '',
        cellphone: user_info["telephone"],
        email: "copper" + user_info["uaid"].to_s + "@example.com"
      }
      user = User.create! new_gold
      user.add_role :gold

      employer = Employer.find_by hospital_id: hospital.id
      employer.user_id = user.id
      employer.save

      sign_in(user)
      redirect_to employer_resumes_path
    end

    # 定义主页
    def copper_home
      if params[:to] == 'fair'
        to_url = webapp_job_fairs_path
      elsif params[:lat] && params[:lng]
        to_url = "/webapp/home?lat=#{params[:lat]}&lng=#{params[:lng]}"
      else
        to_url = "/webapp/home"
      end

      return to_url
    end


end
