class PlayerStatsController < ApplicationController
  before_action :load_player_stats, only: :index
  before_action :load_match_stats, only: :index

  def index
  end

  def new
    @player_stat = PlayerStat.new
  end

  def create
    @player_stat = PlayerStat.new(player_stat_params)
    if @player_stat.save
      redirect_to pages_home_path, notice: "Player stat created succesfully"
    else
      render :new
    end
  end

  private

  def load_player_stats
    @player_stats = PlayerStat.all
  end

  def load_match_stats
    @match_stats = MatchStat.all
  end

  def player_stat_params
    params.require(:player_stat).permit(:user_id)
  end
end
