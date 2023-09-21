class AddGameResultToGamePlayerResults < ActiveRecord::Migration[6.1]
  def change
    add_reference :game_player_results, :game_result, null: false, foreign_key: true
  end
end
