# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :on_going_game, only: %i[new create show edit_points update_points]
  before_action :set_available_users, only: %i[new edit_points]
  after_action :assign_place, only: %i[update_points]

  DATE = Time.zone.now - 6.hour

  def index
    @games = Game.all
  end

  def new
    if @on_going_game.nil? || @on_going_game.player_game_results.present?
      @game = Game.new
      @game.player_game_results.build
    end
  end

  def create    
    if @on_going_game.nil?
      @game = Game.new(game_params)
      @game.player_game_results.build(user_id: current_user.id) if @game.player_game_results.empty?
      if @game.save
        redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
      else
        redirect_to games_new_path, notice: "Error: #{ @game.errors.full_messages.to_sentence }"
      end
    else
      @on_going_game.assign_attributes(game_params)
      @on_going_game.player_game_results.build(user_id: current_user.id) if @on_going_game.player_game_results.empty?
      if @on_going_game.save
        redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
      else
        redirect_to games_new_path, notice: "Error: #{ @on_going_game.errors.full_messages.to_sentence }"
      end
    end
  end

  def show
    @game = @on_going_game
  end

  def edit_points
    @users_with_pts = User.joins(:player_game_results).where.not(player_game_results: { id: nil })
  end

  def update_points
    if @on_going_game.update(game_params)
      redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
    else
      flash.now[:alert] = "Error al ingresar puntos: #{@on_going_game.errors.full_messages.to_sentence}"
      render :edit_points
    end
  end

  private

  def game_params
    params.require(:game).permit(:date, player_game_results_attributes: %i[id user_id points draw win_by_draw draw_with])
  end

  def set_available_users
    today_game = Game.where(date: DATE.beginning_of_day..DATE.end_of_day)
    logged_users_by_date = PlayerGameResult.where(game: today_game).pluck(:user_id)
    @available_users = User.where.not(id: logged_users_by_date)
  end

  def on_going_game
    return if Game.all.empty?

    @on_going_game = Game.find_by(date: DATE)
  end

  def assign_place
    return 'Missing players results' unless @on_going_game.player_game_results.count == User.count

    ordered_results = @on_going_game.player_game_results.order(points: :desc)

    ordered_results.each.with_index(1) do |player_game_result, index|
      player_game_result.update(points: player_game_result.points + 1) if player_game_result.win_by_draw
      player_game_result.update(place: index )
    end
  end
end
