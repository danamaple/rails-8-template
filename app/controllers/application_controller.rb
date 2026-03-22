class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name,
      :smtp_address, :smtp_port, :smtp_username, :smtp_password, :smtp_from_email
    ])
  end
end
