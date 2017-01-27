class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_tour
    if params[:action] == "new" && params[:controller] == "student_checks"
      Tour.find(params[:tour_id])
    else
      Tour.find(params[:student_check][:tour_id])
    end
  end
  helper_method :current_tour

  def admin_signed_in?
    current_user.role == "admin"
  end
  helper_method :admin_signed_in?

  def authorize_admin
    if current_user.role != "admin"
      flash[:notice] = "ERROR! Page Does Not Exist"
      redirect_to root_path
    end
  end
  helper_method :authorize_admin

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :role, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
