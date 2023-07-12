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
    # @users = WeeklyScore.where(week_number: Date.current.strftime('%U').to_i - 1).collect{ |weekly_score| weekly_score.user }.flatten.uniq
    # @users = User.includes(:player_match_results).order('player_match_results.points DESC')
    ordered_place_pmr = PlayerMatchResult.order(points: :desc)
    pmr_unique_by_user = ordered_place_pmr.uniq{ |pmr| pmr.user_id }
    @users = pmr_unique_by_user.collect{ |pmr| pmr.user }
  end

  def draw; end

  private

  def load_matches
    @matches = Match.order(created_at: :desc).all
  end
end
