class CreateGamePlayerResults < ActiveRecord::Migration[6.1]
  def change
    create_table :game_player_results do |t|
      t.integer :place
      t.integer :points
      t.boolean :draw
      t.boolean :win_by_draw
      t.string :draw_with
      # t.references :game_result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
