class CreatePlayerMatchResults < ActiveRecord::Migration[6.1]
  def change
    create_table :player_match_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :points
      t.integer :place

      t.timestamps
    end
  end
end
