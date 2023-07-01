class MatchesController < ApplicationController
  def new
    @match = Match.new
    @match.player_match_results.build
    @available_users = User.left_outer_joins(:player_match_results).where(player_match_results: { id: nil })
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to new_match_path, notice: "Player points entered successfully."
    else
      flash.now[:alert] = "Failed to create match."
      render :new
    end
  end

  private

  def match_params
    params.require(:match).permit(:date, player_match_results_attributes: [:id, :user_id, :points])
  end
end
