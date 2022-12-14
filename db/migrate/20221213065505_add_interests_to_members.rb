class AddInterestsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :interests, :jsonb
  end
end
