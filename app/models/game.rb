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
class Game < ApplicationRecord
  belongs_to :tournament, optional: true
  has_one :game_result, dependent: :destroy
  has_many :player_game_results, dependent: :destroy
  has_many :users, through: :player_game_results
  accepts_nested_attributes_for :player_game_results

  after_create :set_week_number

  def submitted_users
    users.pluck(:id)
  end

  def set_week_number
    self.week_number = date.strftime('%U').to_i
    save
  end
end
