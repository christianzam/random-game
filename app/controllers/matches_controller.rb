class MatchesController < ApplicationController
  before_action :set_available_users, only: :new
  before_action :set_editable_match, only: %i(new edit_points update_points)

  def new
    @match = Match.where(date: Time.zone.now).last
    if @match.nil? || @match.player_match_results.present?
      @match = Match.new(date: Time.zone.now)
      @match.player_match_results.build
    end
  end

  def create
    @match = Match.where(date: Time.zone.now).last
    if @match.nil?
      @match = Match.new(match_params)
      @match.player_match_results.build(user_id: current_user.id) if @match.player_match_results.empty?
    else
      @match.assign_attributes(match_params)
      @match.player_match_results.build(user_id: current_user.id) if @match.player_match_results.empty?
    end
  
    if @match.save
      redirect_to new_match_path, notice: "Los puntos han sido ingresados"
    else
      flash.now[:alert] = "Failed to create match."
      render :new
    end
  end
  

  def show
    @match = Match.find(params[:id])
  end

  def edit_points
    @users_with_pts = User.joins(:player_match_results).where.not(player_match_results: { id: nil })
  end
  
  def update_points
    if @match_to_edit.update(match_params)
      redirect_to new_match_path, notice: "Player points updated successfully."
    else
      flash.now[:alert] = "Failed to update player points."
      render :edit_points
    end
  end
  
  private

  def match_params
    params.require(:match).permit(:date, player_match_results_attributes: [:id, :user_id, :points])
  end

  def set_available_users
    # @available_users = User.left_outer_joins(:player_match_results).where(player_match_results: { id: nil })
    today_matches = Match.where(date: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    used_users = PlayerMatchResult.where(match: today_matches).pluck(:user_id)
    @available_users = User.where.not(id: used_users)
  end

  def set_editable_match
    return if Match.all.empty?

    @match_to_edit = Match.where(date: Time.zone.now).last
    @match_to_edit.date = Time.zone.now
  end
end
