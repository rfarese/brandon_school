class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_tour
    if params[:action] == "edit" && params[:controller] == "student_checks"
      Tour.current_tour(params[:tour_id])
    elsif params[:action] == 'update' && params[:controller] == 'student_checks'
      Tour.find(params[:student_checks][:student_checks].first[1][:tour_id])
    else
      Tour.find(params[:student_check][:tour_id])
    end
  end
  helper_method :current_tour

  def admin_signed_in?
    current_user.role == "admin"
  end
  helper_method :admin_signed_in?

  def supervisor_signed_in?
    current_user.role == "supervisor"
  end
  helper_method :supervisor_signed_in?

  def authorize_admin_and_supervisor
    if current_user.role == "overnight_staff" 
      flash[:notice] = "ERROR! Page Does Not Exist"
      redirect_to root_path
    end
  end

  def authorize_admin
    if current_user.role != "admin"
      flash[:notice] = "ERROR! Page Does Not Exist"
      redirect_to root_path
    end
  end
  helper_method :authorize_admin

  def find_ids(status, student_checks)
    ids = []

    student_checks.each do |student_check|
      if status == "all"
        ids << student_check.id
      else
        ids << student_check.id if student_check.status == status
      end
    end
    ids
  end
  helper_method :find_ids

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :role, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
