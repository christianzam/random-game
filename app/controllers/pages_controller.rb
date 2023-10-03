class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :landing ]
  before_action :load_game, only: %i(draw run_draw)
  
  def landing
    if user_signed_in?
      redirect_to pages_home_path
    else
      redirect_to new_user_session_path
    end
  end

  def draw
  end

  def run_draw
    users_draw = @game.users.shuffle

    respond_to do |format|
      format.js {render json: { users: users_draw }, status: :ok}
      format.html {render json: { users: users_draw }, status: :ok}
    end    
  end
  

  def home
    @users = User.joins(:player_game_results)
                  .select('users.*, SUM(player_game_results.points) AS total_points')
                  .group('users.id')
                  .order('total_points DESC')
  end

  private

  def load_game
    @game = Game.find_by(id: params[:game_id])
  end
end
