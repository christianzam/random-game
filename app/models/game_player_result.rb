# == Schema Information
#
# Table name: game_player_results
#
#  id             :bigint           not null, primary key
#  draw           :boolean
#  draw_with      :string
#  place          :integer
#  points         :integer
#  win_by_draw    :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  game_result_id :bigint           not null
#
# Indexes
#
#  index_game_player_results_on_game_result_id  (game_result_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_result_id => game_results.id)
#
class GamePlayerResult < ApplicationRecord
  belongs_to :game_result
end
