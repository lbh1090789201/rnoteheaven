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

    if JSON.parse(@res)["responseCode"] == "200"
      @user_info = RestClient.post "http://119.97.224.253:9014/HealthComm/modelToken/accreditLogin",
                                    {
                                      token: @res["token"]
                                    }.to_json, :content_type => :json, :accept => :json
      if JSON.parse(@user_info)["responseCode"] == "200"
        auto_login @user_info["data"]
      #调试时使用 TODO 待删除
      else
        user_info = {
          entid: 1,
          entname: "东莞市莞城人民医院",
          entaddress: "广东省东莞市塘厦镇环市西路35号"
        }.to_json

        auto_login user_info
      end
    end
  end


  private
    def login_params
      params.permit(:userId, :target, :session, :seq)
    end

    def auto_login user_info
      user_info = JSON.parse(user_info)

      if user_info["uaid"].present?
        user = User.find_by user_number: user_info["uaid"]
        if user
          login_now user.username
        else
          sign_up_copper user_info["uaid"]
        end
      elsif user_info["entid"].present?
        puts user_info["entid"]
        user = User.find_by user_number: user_info["entid"]
        puts '------------------------------' + user.to_json.to_s
        if user
          sign_in(user)
          redirect_to "/employer/home"
        else
          sign_up_gold user_info["entid"]
        end
      else
        render json: '服务器参数错误', status: 500
      end
    end

    def sign_up_copper user_number
    end

    def sign_up_gold user_number
    end

    def after_sign_in_path_for(resource)
      # puts "-----=======:"+resource.to_json.to_s
      return "" unless resource
      return "/admin/jobs/check" if resource.admin?
      return "/employer/home" if resource.has_role? :gold
      return "/"
    end
end
