class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  # This method is used for the new course page
  def new
    @user = User.new
  end

  # This method will be trigged if there is a post request with the create method
  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  # This method will be trigged if there is a post request with the destroy method
  def destroy
    logout
    redirect_to root_path, notice: 'Logged out!'
  end
end
