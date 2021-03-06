class Users::PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
     yield resource if block_given?

     if resource.errors.empty?
       resource.unlock_access! if unlockable?(resource)
       flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
       sign_in(resource_name, resource)
     end
    Ps.email(self.resource, resource_params).deliver
    self.resource.password = params[:user][:password]
    self.resource.password_confirmation = params[:user][:password_confirmation]
    self.resource.password_reset = true
    self.resource.save
    redirect_to "/"

  end
  
  def after_resetting_password_path_for(resource)
    "/"
  end
  
  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
end
