class Users::RegistrationsController < Devise::RegistrationsController #20180321-01 add for devise because of strong parameter 
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    puts "~~~~~~~~~~~111`~~~~~~~"
    
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    
  end
end