class MatchStatsController < ApplicationController
  before_action :load_player_stat, only: :create

  def new
    @match_stat = MatchStat.new
  end

  def create
    @match_stat = MatchStat.new(match_stat_params)
    @match_stat.player_stat_id = @player_stat.id

    if @match_stat.save
      redirect_to pages_home_path, notice: "Match stat created successfully"
    else
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      puts @match_stat.errors.full_messages.to_sentence.capitalize
      render :new
    end
  end

  private

  def match_stat_params
    params.require(:match_stat).permit(:user_id, :points, :position, :match_date)
  end

  def load_player_stat
    @player_stat = PlayerStat.find_by(user_id: match_stat_params[:user_id])
  end
end
