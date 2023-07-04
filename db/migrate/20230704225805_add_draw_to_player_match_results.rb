class AddDrawToPlayerMatchResults < ActiveRecord::Migration[6.1]
  def change
    add_column :player_match_results, :draw, :boolean
  end
end
