module PagesHelper
  WEEK = Date.current.beginning_of_week..Date.current.end_of_week(:saturday)

  def result 
    @result = %w(Lalo Pato Chris Tinoco Kike Diego).shuffle
  end

  def total_points(user)
    return 0 if user.player_match_results.nil?

    user.player_match_results.sum(:points) * 2
  end

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

  def score_avrg(user)
    total_pts = user.player_match_results.sum(:points)
    total_pts / user.player_match_results.joins(:match).size
  end

  def total_matches(user)
    user.player_match_results.joins(:match).size
  end
end
