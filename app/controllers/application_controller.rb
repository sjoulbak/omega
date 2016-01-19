class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def require_admin
    if !current_user.admin?
      redirect_to root_path, alert: "Geen bevoegdheid"
    end
  end

  def require_not_logged_in_or_admin
    if !current_user.nil?
      if !current_user.admin?
        redirect_to root_path, alert: "Geen bevoegdheid"
      end
    end
  end

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  protect_from_forgery with: :exception
end
