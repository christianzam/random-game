class CreateSanta < ActiveRecord::Migration[6.1]
  def change
    create_table :santa do |t|
      t.string :nickname
      t.string :email
      t.string :give_to
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
