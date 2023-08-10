# == Schema Information
#
# Table name: games
#
#  id                :bigint           not null, primary key
#  date              :date
#  number_of_players :integer
#  week_number       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  game_result_id    :bigint           not null
#
# Indexes
#
#  index_games_on_game_result_id  (game_result_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_result_id => game_results.id)
#
require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
