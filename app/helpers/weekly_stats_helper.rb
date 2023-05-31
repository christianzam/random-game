module WeeklyStatsHelper
  def current_week_dates
    today = Date.today
    monday = today - (today.wday - 1) % 7
    friday = monday + 4
  
    "#{monday.strftime('%d/%b')}  a  #{friday.strftime('%d/%b')}"
  end  

  def current_week_range
    start_date = Date.current.beginning_of_week
    end_date = Date.current.end_of_week
    (start_date..end_date)
  end

  def games_played(user)
    user.match_stats.where(match_date: current_week_range).count
  end
end