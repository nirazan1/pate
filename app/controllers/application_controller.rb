class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :middle_name, :last_name, :location, :username, :country]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :middle_name, :last_name, :location, :username, :country, :info, :avatar]
  end

  def after_sign_up_path_for(resource)
    feeds_index_path
  end

  def after_sign_in_path_for(resource)
    feeds_index_path
  end

  def signed_in?
    current_user.present?
  end
  helper_method :signed_in?

  protected

  def authenticate!
    redirect_to new_session_path and return unless signed_in?
  end


end
