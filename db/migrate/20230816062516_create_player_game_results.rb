class CreatePlayerGameResults < ActiveRecord::Migration[6.1]
  def change
    create_table :player_game_results do |t|
      t.boolean :draw
      t.integer :draw_with
      t.integer :place
      t.integer :points
      t.boolean :win_by_draw
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
