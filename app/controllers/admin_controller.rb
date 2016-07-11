class AdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?


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
      redirect_to root_path
    end
  end

  # Only permits employer
  helper_method :require_jobs_manager!
  def require_jobs_manager!
    authenticate_user!
    if current_user && !current_user.jobs_manager?
      redirect_to root_path
    end
  end

  # Only permits copper
  helper_method :require_employer!
  def require_jobs_manager!
    authenticate_user!
    if current_user && !current_user.jobs_manager?
      redirect_to root_path
    end
  end

end
