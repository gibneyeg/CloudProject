class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  #handles unauthorized access attempts
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_up_path_for(_resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end
end
