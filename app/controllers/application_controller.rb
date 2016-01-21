class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Check if user is admin
  def require_admin
    if !current_user.admin?
      redirect_to root_path, alert: "Geen bevoegdheid"
    end
  end

  # Check if user isnt logged in or admin
  def require_not_logged_in_or_admin
    if !current_user.nil?
      if !current_user.admin?
        redirect_to root_path, alert: "Geen bevoegdheid"
      end
    end
  end

  private

  # Redirect path if user isnt logged in
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  protect_from_forgery with: :exception
end
