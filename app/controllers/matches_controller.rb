class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to root_path, notice: "Match data has been successfully recorded."
    else
      render :new
    end
  end

  private

  def match_params
    params.require(:match).permit(:date)
  end
end

