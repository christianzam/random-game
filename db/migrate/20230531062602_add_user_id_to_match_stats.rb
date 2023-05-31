class AddUserIdToMatchStats < ActiveRecord::Migration[6.1]
  def change
    add_reference :match_stats, :user, foreign_key: true
  end
end
