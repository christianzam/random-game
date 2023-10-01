# frozen_string_literal: true

class PlayerGameResultsController < ApplicationController
  before_action :load_player_game_result, only: :show
  # before_action :load_game, only: %i(create)

  def new
    @player_game_result = PlayerGameResult.new
  end

  def create
    @player_game_result = PlayerGameResult.new(player_game_result_params)

    if @player_game_result.save
      redirect_to player_game_result_path(@player_game_result), notice: 'PlayerGameResult success'
      puts 'save ============='
    else
      flash[:alert] = "#{@player_game_result.errors.full_messages.to_sentence}"
      render :new
      puts "#{@player_game_result.errors.full_messages.to_sentence}"
    end
  end

  def show; end

  private
  
  def load_player_game_result
    @player_game_result = PlayerGameResult.find(params[:id])
  end 

  # def load_game
  #   @game = Game.find(params[:game_id])
  # end

  def player_game_result_params
    params.require(:player_game_result).permit(:game_id, :user_id)
  end
end