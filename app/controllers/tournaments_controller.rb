class TournamentsController < ApplicationController
  before_action :load_tournament, only: %i(show edit update)

  def index 
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def show; end

  def create
    @tournament = Tournament.new(tournament_params)
    
    if @tournament.save
      render json: { tournament: @tournament }, status: :ok
    else
      render :new, notice: 'Hubo un problema al crear el torneo'
    end
  end

  def edit; end

  def update
    if @tournament.update(tournament_params)
      redirect_to tournaments_path, notice: 'Tournament successfully updated!'
    else
      render :edit, alert: "Oops somethind went wrong, #{@tournament.errors.to_sentence.to_s}"
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :start_date, :end_date, :period_tournament, :tournament_picture, game_attributes: %i[id week_number date number_of_players])
  end

  def load_tournament
    @tournament = Tournament.find params[:id]
  end
end
