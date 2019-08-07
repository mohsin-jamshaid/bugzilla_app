class HomeController < ApplicationController
  def index
    user_signed_in? ? (redirect_to projects_path) : (redirect_to new_user_session_path)
  end
end
