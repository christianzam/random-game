class CreatePlayerMatchResults < ActiveRecord::Migration[6.1]
  def change
    create_table :player_match_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.boolean :draw, default: false
      t.boolean :win_by_draw, default: false
      t.string :draw_with
      t.integer :points
      t.integer :place

      t.timestamps
    end
  end
end
