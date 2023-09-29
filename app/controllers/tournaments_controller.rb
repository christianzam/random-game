class TournamentsController < ApplicationController

  def index 
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    
    if @tournament.save
      redirect_to tournaments_path, notice: 'El torneo se ha creado correctamente'
    else
      render :new, notice: 'Hubo un problema al crear el torneo'
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :start_date, :end_date, :period_tournament, :tournament_picture, game_attributes: %i[id week_number date number_of_players])
  end
end