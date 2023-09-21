class CreateGameResults < ActiveRecord::Migration[6.1]
  def change
    create_table :game_results do |t|
      t.jsonb :places
      t.string :winner
      t.integer :draws
      t.integer :winners_by_draws
      # t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
