# == Schema Information
#
# Table name: game_results
#
#  id               :bigint           not null, primary key
#  draws            :integer
#  places           :jsonb
#  winner           :string
#  winners_by_draws :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  game_id          :bigint           not null
#
# Indexes
#
#  index_game_results_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
require 'rails_helper'

RSpec.describe GameResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
