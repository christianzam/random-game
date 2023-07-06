module PagesHelper
  WEEK = Date.current.beginning_of_week..Date.current.end_of_week(:saturday)

  def total_place(user)
    user_results = user.player_match_results.joins(:match).where(matches: { date: WEEK }) # Retrieve the user's match results for the current WEEK
    user_points = user_results.sum(:points) # Calculate the total points for the user
  
    # Determine the place based on the total points
    PlayerMatchResult.joins(:match)
                      .where(matches: { date: WEEK })
                      .where('points > ?', user_points)
                      .order(points: :desc)
                      .count + 1

  end

  def total_points(user)
    return 0 if user.player_match_results.nil? || user.player_match_results.empty?

    user.player_match_results.sum(:points) * 2
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

  def bar_color(user)
    return 0 if user.player_match_results.nil? || user.player_match_results.empty?

    num = (user.player_match_results.sum(:points) / user.player_match_results.joins(:match).size) * 10
    
    if (0..35).include?(num)
      'red'
    elsif (36..66).include?(num)
      'purple'
    elsif (67..100).include?(num)
      'green'
    end
  end
end
