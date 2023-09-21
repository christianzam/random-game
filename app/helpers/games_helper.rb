# frozen_string_literal: true

module GamesHelper

  def boolean_answer(value)
    return '-' if value.nil?

    value ? 'Si' : 'No'
  end

  def places_icons(place)
    case place
    when 1
      "#{place.ordinalize}🥇"
    when 2
      "#{place.ordinalize}🥈"
    when 3
      "#{place.ordinalize}🥉"
    else
      place.ordinalize
    end
  end

  def draw_with_answer(id)
    return '-' if id.nil?

    "con: #{User.find(id).name}"
  end
end