class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
