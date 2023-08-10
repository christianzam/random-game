class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :landing ]
  
  def landing
    if user_signed_in?
      redirect_to pages_home_path
    else
      redirect_to new_user_session_path
    end
  end

  def home
    @users = User.all
  end

  def draw; end
end
