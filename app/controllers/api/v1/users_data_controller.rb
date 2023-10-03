class Api::V1::UsersDataController < ApplicationController
  before_action :load_user

  def show
    render json: user_data, status: :found if @user.present?
  end

  def user_data
   { 
    score_avrg: @user.score_avrg,
    games_played: @user.games_played,
    ranking: @user.ranking
   }
  end

  private

  def load_user
    @user = User.find(params[:id])
    return render json: { status: 'Error', message: 'User not found' }, status: :not_found if @user.nil?
  end
end