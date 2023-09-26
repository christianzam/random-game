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
    @users = User.joins(:player_game_results)
                  .select('users.*, SUM(player_game_results.points) AS total_points')
                  .group('users.id')
                  .order('total_points DESC')
  end

  def draw; end
end
