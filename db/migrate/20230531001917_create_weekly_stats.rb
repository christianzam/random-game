class CreateWeeklyStats < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_stats do |t|
      t.date :week_start_date
      t.date :week_end_date
      t.integer :total_points
      t.integer :total_places
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
