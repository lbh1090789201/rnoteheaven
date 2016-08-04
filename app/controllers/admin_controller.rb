class AdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :show_tabs

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

  # Only permits employer
  helper_method :require_jobs_manager!
  def require_jobs_manager!
    authenticate_user!
    if current_user && !current_user.jobs_manager? && !current_user.admin? && !current_user.admin?
      redirect_to root_path
    end
  end

  # Only permits copper
  helper_method :require_resumes_manager!
  def require_resumes_manager!
    authenticate_user!
    if current_user && !current_user.resumes_manager? && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :require_hospitals_manager!
  def require_hospitals_manager!
    authenticate_user!
    if current_user && !current_user.hospitals_manager? && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :require_fairs_manager!
  def require_fairs_manager!
    authenticate_user!
    if current_user && !current_user.fairs_manager? && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :require_vips_manager!
  def require_vips_manager!
    authenticate_user!
    if current_user && !current_user.vips_manager? && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :require_acounts_manager!
  def require_acounts_manager!
    authenticate_user!
    if current_user && !current_user.acounts_manager? && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :show_tabs
  def show_tabs
    if current_user && current_user.admin?
      @show_tabs = [true, true, true, true, true, true]
    elsif current_user
      @show_tabs = [current_user.jobs_manager?, current_user.resumes_manager?, current_user.hospitals_manager?,
                  current_user.fairs_manager?, current_user.vips_manager?, current_user.acounts_manager?]
    else

    end
  end

end
