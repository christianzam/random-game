module DrawsConcern
  extend ActiveSupport::Concern

  def start_draw(group_id)
    group = Group.find_by(id: group_id).members.shuffle
    group << group.first
    @draw_result = group.each_cons(2).to_a.shuffle
  end

  def update_giving_to
    @draw_result.each do |pair|
      member = Member.find_by(nickname: pair.first)
      member.update(give_to: pair.last) if member.present?
    end
  end
end