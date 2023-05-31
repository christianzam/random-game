class CreateMatchStats < ActiveRecord::Migration[6.1]
  def change
    create_table :match_stats do |t|
      t.references :player_stat, null: false, foreign_key: true
      t.integer :points
      t.integer :position

      t.timestamps
    end
  end
end
