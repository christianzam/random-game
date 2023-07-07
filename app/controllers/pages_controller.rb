class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :landing ]
  before_action :load_matches, only: :home
  
  def landing
    if user_signed_in?
      redirect_to pages_home_path
    else
      redirect_to new_user_session_path
    end
  end

  def home
    @users = User.includes(:player_match_results).order('player_match_results.points DESC')
  end

  def draw; end

  private

  def load_matches
    @matches = Match.order(created_at: :desc).all
  end
end
