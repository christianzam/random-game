# frozen_string_literal: true

module Pages
  # Table methods for use only at home
  module HomeHelper
    CURRENT_WEEK = (Date.current.beginning_of_week..Date.current.end_of_week(:saturday)).freeze

    def weekly_place(user)
      # Retrieve the user's match results for the current WEEK
      # user_results = user.player_game_results.joins(:game).where(game: { date: CURRENT_WEEK })
    end

    def total_place(user)
      # Calculate the total points for the user
      user_results = user.player_game_results.joins(:game)
      user_points = user_results.sum(:points)

      # Determine the place based on the total points
      PlayerGameResult.joins(:game)
                       .where('points > ?', user_points)
                       .order(points: :desc)
                       .count + 1
    end

    def place_and_medal(index)
      place = index + 1

      case place
      when 1
        "#{place.ordinalize}🥇"
      when 2
        "#{place.ordinalize}🥈"
      when 3
        "#{place.ordinalize}🥉"
      else
        place
      end
    end

    def total_points(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      user.player_game_results.sum(:points)
    end

    def score_avrg(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      (user.player_game_results.sum(:points) / user.player_game_results.joins(:game).size) * 10
    end

    def total_draws(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      user.player_game_results.where(draw: true).size
    end

    def total_draws_won(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      user.player_game_results.where(winning_draw: true).size
    end

    def total_games(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      user.player_game_results.size
    end

    def total_goals(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      user.player_game_results.sum(:points)
    end

    def score_bar_div(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      content_tag(:div, '', class: "bg-#{bar_color(user)}-600 h-2.5 rounded-full dark:bg-#{bar_color(user)}-500",
                            style: "width: #{score_avrg(user)}%")
    end

    def bar_color(user)
      return 0 if user.player_game_results.nil? || user.player_game_results.empty?

      num = (user.player_game_results.sum(:points) / user.player_game_results.joins(:game).size) * 10

      case num
      when 0..35
        'red'
      when 36..66
        'purple'
      when 67..100
        'green'
      end
    end
  end
end
