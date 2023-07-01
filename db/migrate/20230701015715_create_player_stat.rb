class CreatePlayerStat < ActiveRecord::Migration[6.1]
  def change
    create_table :player_stats do |t|
      t.users :references
      t.integer :total_points
      t.integer :age
      t.string :nationality
      t.integer :matches_won

      t.timestamps
    end
  end
end
