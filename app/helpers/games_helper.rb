# frozen_string_literal: true

module GamesHelper

  def tournament_name(game)
    return 'Friendly game' if game&.tournament&.name.nil?

    game&.tournament&.name
  end

  def boolean_answer(value)
    return '-' if value.nil?

    value ? 'Si' : 'No'
  end

  def places_icons(index, player_game_result)
    return '' if player_game_result.points.nil?

    case index
    when 1
      "#{index.ordinalize}🥇"
    when 2
      "#{index.ordinalize}🥈"
    when 3
      "#{index.ordinalize}🥉"
    else
      index.ordinalize
    end
  end

  def draw_with_answer(id)
    return '-' if id.nil?

    "con: #{User.find(id).name}"
  end

  def edit_add_points_title(game)
    game.player_game_results.first.points.nil? ? 'Agregar' : 'Editar'
  end
end