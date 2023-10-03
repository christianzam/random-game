# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :load_tournament, only: :new
  before_action :load_game, only: %i[show edit update]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @game.player_game_results.build
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      render json: { tournament: @game }, status: :ok
    else
      render json: { error: "#{ @game.errors.full_messages.to_sentence } / #{@game.player_game_results.each{|pgr| pgr.errors.full_messages.to_sentence}}" }, status: :internal_server_error
    end
  end

  def show; end

  def edit
    @users = @game.users
  end

  def update
    if @game.update(game_update_params)
      @game.update_game_result
      redirect_to game_path(@game), notice: 'Los puntos se ingresaron correctamente'
    else
      flash.now[:alert] = "#{@game.player_game_results.each{|pgr| pgr.errors.full_messages.to_sentence}}"
      render :edit
    end
  end

  private

  def game_params
    params.require(:game).permit(
      :date,
      :tournament_id,
      user_ids: [],
      player_game_results_attributes: [:id, :points, :draw, :win_by_draw, :draw_with]
    )
  end

  def game_update_params
    params.require(:game).permit(
      player_game_results_attributes: [:id, :user_id, :points, :draw, :win_by_draw, :draw_with]
    )
  end
  
  def load_game
    @game = Game.find(params[:id])
  end
  
  def load_tournament
    @tournament = Tournament.find_by(id: params[:tournament_id])
  end
end
