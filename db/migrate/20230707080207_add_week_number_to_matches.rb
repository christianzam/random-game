class AddWeekNumberToMatches < ActiveRecord::Migration[6.1]
  def change
    add_column :matches, :week_number, :integer
  end
end
