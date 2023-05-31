class AddMatchDateToMatchStat < ActiveRecord::Migration[6.1]
  def change
    add_column :match_stats, :match_date, :date
  end
end
