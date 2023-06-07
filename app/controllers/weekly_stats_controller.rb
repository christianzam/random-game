class WeeklyStatsController < ApplicationController
  def index
    @users = User.all.includes(:player_stats, :match_stats)
    @users_with_total_points = calculate_total_points(@users).sort_by { |u| -u[:total_points] }
  end

  private

  def calculate_total_points(users)
    users.map do |user|
      total_points = user.match_stats.sum(:points)
      { user: user, total_points: total_points }
    end
  end
end
