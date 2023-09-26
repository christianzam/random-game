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

    def papa
      match = Match.where(date: CURRENT_WEEK)
      week_number = match.date.strftime('%U').to_i

      weekly_scores = WeeklyScore.where(week_number: week_number).order(total_points: :desc)
      weekly_score = user.weekly_scores.find_or_initialize_by(week_number: week_number)
  
      @first_place = weekly_scores.first
      @second_place = weekly_scores.second
      @third_place = weekly_scores.third
    end

    def place_and_medal(user)
      place = total_place(user)

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

      user.player_game_results.sum(:points) * 2
    end

    def score_avrg(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      (user.player_match_results.sum(:points) / user.player_match_results.joins(:match).size) * 10
    end

    def total_draws(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      user.player_match_results.where(draw: true).size
    end

    def total_draws_won(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      user.player_match_results.where(winning_draw: true).size
    end

    def total_matches(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      user.player_match_results.size
    end

    def total_goals(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      user.player_match_results.sum(:points)
    end

    def score_bar_div(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      content_tag(:div, '', class: "bg-#{bar_color(user)}-600 h-2.5 rounded-full dark:bg-#{bar_color(user)}-500",
                            style: "width: #{score_avrg(user)}%")
    end

    def bar_color(user)
      return 0 if user.player_match_results.nil? || user.player_match_results.empty?

      num = (user.player_match_results.sum(:points) / user.player_match_results.joins(:match).size) * 10

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
