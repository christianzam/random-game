class AddGameToGameResults < ActiveRecord::Migration[6.1]
  def change
    add_reference :game_results, :game, null: false, foreign_key: true
  end
end
