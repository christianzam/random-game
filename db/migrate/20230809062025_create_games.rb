class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :week_number
      t.date :date
      t.integer :number_of_players
      # t.references :game_result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
