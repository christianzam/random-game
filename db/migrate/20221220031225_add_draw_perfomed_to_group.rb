class AddDrawPerfomedToGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :draw_performed, :boolean
  end
end
