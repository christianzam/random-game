module DrawsConcern
  extend ActiveSupport::Concern

  def start_draw(group_id)
    group = Group.find_by(id: group_id).members.shuffle
    group << group.first
    assigned_draw = group.each_cons(2).to_a
  end
end