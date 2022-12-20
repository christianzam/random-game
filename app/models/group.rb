class Group < ApplicationRecord
  serialize :members, Array

  def ready_for_draw?
    members.size > 2
  end
end
