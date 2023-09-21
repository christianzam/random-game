# == Schema Information
#
# Table name: player_game_results
#
#  id          :bigint           not null, primary key
#  draw        :boolean
#  draw_with   :integer
#  place       :integer
#  points      :integer
#  win_by_draw :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_player_game_results_on_game_id  (game_id)
#  index_player_game_results_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe PlayerGameResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
