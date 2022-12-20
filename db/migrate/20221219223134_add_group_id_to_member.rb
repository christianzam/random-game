class AddGroupIdToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :group_id, :integer
  end
end
