require 'openssl'
require 'base64'
include ValidationCodesHelper
module Api
  class ValidationCodesController < ApiController
    # 获取验证码
    def create
      create_vcode(validation_code_params)
    end

    private
    def validation_code_params
      params.require(:validation_code).permit(
          :cellphone)
    end

  end
end


