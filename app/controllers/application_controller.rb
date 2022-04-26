class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:country])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, :notice => 'Please login before continue!'
    end
  end
end
