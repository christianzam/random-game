# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_available_users, only: %i[new edit_points]
  before_action :set_editable_game, only: %i[new edit_points update_points]
  before_action :set_existing_game, only: %i[new show]

  DATE = Time.zone.now - 6.hour

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @game.player_game_results.build
  end

  def create
    # @match = Match.where(date: DATE).last

    # if @match.nil?
    #   @match = Match.new(match_params)
    #   @match.player_match_results.build(user_id: current_user.id) if @match.player_match_results.empty?
    # else
    #   @match.assign_attributes(match_params)
    #   @match.player_match_results.build(user_id: current_user.id) if @match.player_match_results.empty?
    # end

    # if @match.save
    #   redirect_to matches_new_path, notice: "Los puntos se ingresaron correctamente"
    # else
    #   redirect_to matches_new_path, alert: "Error: #{@match.errors.full_messages.first}"
    # end
    
    @game = Game.new(game_params)
    @game.player_game_results.build(user_id: current_user.id) if @game.player_game_results.empty?

    if @game.save
      redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
    else
      redirect_to games_new_path, notice: "Error: #{@game.errors.full_messages.to_sentence}"
    end
  end

  def show
    @game = @existing_game
  end

  def edit_points
    @users_with_pts = User.joins(:player_game_results).where.not(player_game_results: { id: nil })
  end

  def update_points
    if @game_to_edit.update(game_params)
      redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
    else
      flash.now[:alert] = "Error al ingresar puntos: #{@game_to_edit.errors.full_messages.to_sentence}"
      render :edit_points
    end
  end

  private

  def game_params
    params.require(:game).permit(:date, player_game_results_attributes: %i[id user_id points])
  end

  def set_available_users
    today_game = Game.where(date: DATE.beginning_of_day..DATE.end_of_day)
    logged_users_by_date = PlayerGameResult.where(game: today_game).pluck(:user_id)
    @available_users = User.where.not(id: logged_users_by_date)
  end

  def set_existing_game
    return if Game.all.empty?

    @existing_game = Game.find_by(date: DATE)
  end

  def set_editable_game
    return if Game.all.empty?

    @game_to_edit = Game.where(date: DATE).last
    @game_to_edit.date = DATE if @game_to_edit.present?
  end
end
