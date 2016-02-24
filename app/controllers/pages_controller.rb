class PagesController < ApplicationController
  skip_before_action :require_login

  # This method is used for the home page
  def home
  end

  # This method is used for the contacts page
  def contacts
    @employees = User.where(admin: true)
  end
end
