class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_admin]
  before_action :require_admin, only: [:index, :destroy, :toggle_admin]
  before_action :require_not_logged_in_or_admin, only: [:new, :create]
  before_action :check_user, only: [:show, :edit, :update]
  skip_before_action :require_login, only: [:new, :create]

  # This method is used for the index users page
  def index
    @users = User.all
  end

  # This method is used for the show user page
  def show
  end

  # This method is used for the new user page
  def new
    @user = User.new
  end

  # This method is used for the edit user page
  def edit
  end

  # This method will be trigged if there is a post request with the create method
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'User was successfully created'
    else
      render action: 'new'
    end
  end

# This method will be trigged if there is a post request with the update method
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        render action: 'edit'
      end
    end
  end

  # This method will be trigged if there is a post request with the destroy method
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_admin
    @user.toggle!(:admin)
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def check_user
      if !current_user.admin?
        redirect_to(users_path, alert: 'Geen bevoegdheid') if current_user != @user
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
