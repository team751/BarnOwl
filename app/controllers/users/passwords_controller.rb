class Users::PasswordsController < Devise::PasswordsController
  def update
    Ps.email(self.resource, resource_params).deliver
    super
    self.resource.password_reset = true
    self.resource.save
  end
  
  def after_resetting_password_path_for(resource)
    "/"
  end
  
  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
end
