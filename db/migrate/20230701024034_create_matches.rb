class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.date :date
      t.integer :week_number
      t.integer :day_number
      t.integer :players_count, default: 0
      t.string :winner

      t.timestamps
    end
  end
end
