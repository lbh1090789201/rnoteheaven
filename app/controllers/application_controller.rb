class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_cache_headers
  # before_filter :reject_locked!, if: :devise_controller?

  #alias_method :devise_current_user, :current_user
  #alias_method :devise_user_signed_in?, :user_signed_in?

  #include DeviseTokenAuth::Concerns::SetUserByToken

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :username,
      :show_name,
      :cellphone,
      :email,
      :password,
      :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :username,
      :show_name,
      :cellphone,
      :email,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end


  # Only permits admin users
  helper_method :require_admin!
  def require_admin!
    authenticate_user!
    if current_user && !current_user.admin?
      redirect_to '/users/sign_in'
    end
  end

  # Only permits employer
  helper_method :require_employer!
  def require_employer!
    authenticate_user!
    if current_user && !current_user.employer?
      redirect_to root_path
    end
  end

  # Only permits copper
  helper_method :require_copper!
  def require_copper!
    authenticate_user!
    if current_user && !current_user.copper?
      redirect_to root_path
    end
  end

  private
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
