class ChangeColumnUserIdInMembers < ActiveRecord::Migration[6.1]
  def change
    change_column :members, :user_id, :bigint, null:true
  end
end
