class CreateWeeklyResults < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_results do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :place
      t.integer :total_points

      t.timestamps
    end
  end
end