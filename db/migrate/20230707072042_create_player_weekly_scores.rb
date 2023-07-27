class CreatePlayerWeeklyScores < ActiveRecord::Migration[6.1]
  def change
    create_table :player_weekly_scores do |t|
      t.bigint :user_id, null: false
      t.integer :week_number
      t.integer :total_points, default: 0
      t.integer :place, default: 0
      t.timestamps null: false
    end

    add_index :player_weekly_scores, [:user_id, :week_number], unique: true
  end
end
