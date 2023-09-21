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
#  tournament_id     :bigint
#
# Indexes
#
#  index_games_on_tournament_id  (tournament_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#
require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
