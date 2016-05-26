#https://github.com/lynndylanhurley/devise_token_auth#im-having-trouble-using-this-gem-alongside-activeadmin
class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :username,
      :show_name,
      :cellphone,
      :avatar,
      :email,
      :password,
      :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :username,
      :show_name,
      :cellphone,
      :avatar,
      :email,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # 格式化时间
  def format_datetime(aDatetime)
    aDatetime.strftime('%Y-%m-%d %H:%M:%S') if aDatetime
  end
  # 格式化日期
  def format_date(aDatetime)
    aDatetime.strftime('%Y-%m-%d') if aDatetime
  end
end
