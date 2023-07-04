class AddDrawToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :draw, :boolean
  end
end
