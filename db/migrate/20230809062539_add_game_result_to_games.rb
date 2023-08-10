class AddGameResultToGames < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :game_result, null: false, foreign_key: true
  end
end
