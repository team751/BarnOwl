class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :check_registration
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        request.fullpath != "/users/sign_out" &&
        !request.xhr? &&
        (request.format == "text/html" || request.content_type == "text/html")) # don't store ajax calls
        session[:previous_url] = request.fullpath
        session[:last_request_time] = Time.now.utc.to_i
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
  
  def current_user_if_exists
    if current_user
      current_user
    else
      User.new
    end
  end

  private

  def check_registration
      puts "CONTROLLLLL: #{params[:controller]}"
    if current_user
      
      if current_user.password_reset != true && params[:controller] != "users/passwords"
        u = current_user
        u.reset_password_token = User.reset_password_token
        u.save
        
        sign_out :user
        redirect_to "/users/password/edit?reset_password_token=#{u.reset_password_token}"
        return
      else
      end
    end
    # if current_user_if_exists && !current_user.valid?
      # flash[:warning] = "Please finish your #{view_context.link_to "registration", edit_user_registration_url }  before continuing.".html_safe
    # end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :first_name, :last_name, :roles => []) }
  end

end
