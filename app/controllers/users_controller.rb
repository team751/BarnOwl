class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :checkIsAdmin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    authorize! :new, @user, :message => 'Not authorized as an administrator.'
  end

  def edit
  end

  def create
    if current_user
      if !current_user.roles.include? "admin"
        redirect_to "/"
        return
      end
    end

    @user = User.new(params[:user].permit(:email, :first_name, :last_name, :roles, :password, :password_confirmation))
    @user.roles = params[:user][:roles]
    @user.save
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    
    respond_to do |format|

      if @user.update_attributes(user_params)
        @user.certification_ids = params[:user][:certification_ids]
        @user.save!
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :first_name, :last_name, :certifications, :roles => [])
    end
    
    def checkIsAdmin
        if !(current_user.roles.include? "admin")
          redirect_to "/"
          return
        end
    end
end
