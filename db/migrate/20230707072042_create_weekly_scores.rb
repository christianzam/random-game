class CreateWeeklyScores < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_scores do |t|
      t.bigint :user_id, null: false
      t.integer :week_number, null: false
      t.integer :total_points, default: 0
      t.integer :place, default: 0
      t.timestamps null: false
    end

    add_index :weekly_scores, [:user_id, :week_number], unique: true
  end
end
