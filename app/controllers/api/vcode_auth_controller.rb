module Api
  class VcodeAuthController < ApiController
    def create

    end

    def verify_user_and_phone
      u = User.find_by(cellphone:user_verification_params[:cellphone])
      if u
        if u.verify_vcode_and_set_username! user_verification_params[:vcode]
        render json: {
            success:true,
            info: '验证通过',
            data: {
            id:u.id
        }
        }, status: 200
        else
          render json: {
              success:false,
              errors:['参数错误']
          }, status: 403
        end
      else
        render json: {
            success:false,
            errors:['用户不存在']
        }, status: 401
      end
    end


    def verify_user_card
      u = User.friendly.find(user_verification_params[:id])
      if u and u.cellphone == user_verification_params[:cellphone]
        if u.verify_vcode_and_set_username! user_verification_params[:vcode]

        else
          render json: {
              success:false,
              errors:['验证码错误']
          },status: 401
        end
      else
        render json: {
            success:false,
            errors:['参数错误']
        }, status: 401
      end
    end
    def user_verification_params
      params.permit(
          :id,
          :cellphone,
          :vcode
      )
    end
  end
end

