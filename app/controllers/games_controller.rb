class GamesController < ApplicationController
  before_action :set_available_users, only: %i(new edit_points)
  before_action :set_editable_game, only: %i(new edit_points update_points)
  before_action :set_existing_game, only: %i(new show)

  DATE = Time.zone.now - 6.hour

  def index
    @games = Game.all
  end

  def new
    # @match = Match.where(date: DATE).last

    # if @match.nil? || @match.player_match_results.present?
    #   @match = Match.new(date: DATE)
    #   @match.player_match_results.build
    # end
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

    @match = Match.new(match_params)
    @match.player_match_results.build(user_id: current_user.id) if @match.player_match_results.empty?

    if @match.save
      redirect_to matches_new_path, notice: "Los puntos se ingresaron correctamente"
    else
      redirect_to matches_new_path, alert: "Error: #{@match.errors.full_messages.first}"
    end
  end

  def show
    @match = @existing_match
  end

  def edit_points
    @users_with_pts = User.joins(:player_match_results).where.not(player_match_results: { id: nil })
  end
  
  def update_points
    if @match_to_edit.update(match_params)
      redirect_to matches_new_path, notice: "Los puntos se ingresaron correctamente"
    else
      flash.now[:alert] = "Error al ingresar puntos: #{@match_to_edit.errors.full_messages}"
      render :edit_points
    end
  end
  
  private

  def match_params
    params.require(:match).permit(:date, player_match_results_attributes: [:id, :user_id, :points])
  end

  def set_available_users
    today_games = Game.where(date: DATE.beginning_of_day..DATE.end_of_day)
    used_users = PlayerGameResult.where(game: today_games).pluck(:user_id)
    @available_users = User.where.not(id: used_users)
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
