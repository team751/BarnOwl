class Users::PasswordsController < Devise::PasswordsController
  def update
    Ps.email(resource_params).deliver
    super
    self.resource.password_reset = true
    self.resource.save
  end
  
  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
end
