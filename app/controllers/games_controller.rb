# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :load_tournament, only: :new
  before_action :load_game, only: %i[show edit]
  # before_action :on_going_game, only: %i[new create show edit_points update_points]
  before_action :set_available_users, only: %i[new edit_points]
  # after_action :assign_place, only: %i[update_points]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    
    # Get the selected user IDs
    # selected_users_ids = params[:game][:player_game_results_attributes].map { |attributes| attributes[:user_id].map(&:to_i) }.flatten

    # selected_users_ids.each do |id|
    #   user = User.find(id)
    #   if user.present?
    #     # PlayerGameResult.where(user_id: user.id).first_or_create
    #     @game.player_game_results.build(user_id: user.id)
    #   end
    # end

    if @game.save
      redirect_to new_game_path, notice: 'Juego creado con éxito'
    else
      render :new, flash[:alert] = "#{@game.errors.full_messages.to_sentence}" 
      puts "errors >> #{@game.errors.full_messages.to_sentence} and #{@game.player_game_results.each{|pgr| pgr.errors.full_messages.to_sentence}} "
    end

  end
  
  
  def show; end

  def edit
    @users_with_pts = @game.users
  end

  # def edit_points
  #   @users_with_pts = User.joins(:player_game_results).where.not(player_game_results: { id: nil })
  # end

  # def update_points
  #   if @on_going_game.update(game_params)
  #     redirect_to games_new_path, notice: 'Los puntos se ingresaron correctamente'
  #   else
  #     flash.now[:alert] = "Error al ingresar puntos: #{@on_going_game.errors.full_messages.to_sentence}"
  #     render :edit_points
  #   end
  # end

  private

  # def game_params
  #   params.require(:game).permit(
  #     :date,
  #     :tournament_id,
  #     player_game_results_attributes: [:id, :user_id, :points, :draw, :win_by_draw, :draw_with]
  #   )
  # end

  def game_params
    params.require(:game).permit(
      :date,
      :tournament_id,
      player_game_results_attributes: [:id, { user_id: [] }, :points, :draw, :win_by_draw, :draw_with]
    )
  end
  
  
  def load_game
    @game = Game.find params[:id]
  end
  
  def load_tournament
    @tournament = Tournament.find_by(params[:tournament_id] || nil)
  end

  # def set_available_users
  #   today_game = Game.where(date: DATE.beginning_of_day..DATE.end_of_day)
  #   logged_users_by_date = PlayerGameResult.where(game: today_game).pluck(:user_id)
  #   @available_users = User.where.not(id: logged_users_by_date)
  # end

  # def on_going_game
  #   return if Game.all.empty?

  #   @on_going_game = Game.find_by(date: DATE)
  # end


  # def assign_place
  #   return 'Missing players results' unless @on_going_game.player_game_results.count == User.count

  #   ordered_results = @on_going_game.player_game_results.order(points: :desc)

  #   ordered_results.each.with_index(1) do |player_game_result, index|
  #     # player_game_result.update(points: player_game_result.points + 1) if player_game_result.win_by_draw
  #     player_game_result.update(place: index)
  #   end
  # end
end
