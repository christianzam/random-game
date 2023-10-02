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

  after_create :assign_number_of_players
  after_create :set_week_number

  def submitted_users
    users.pluck(:id)
  end

  def update_game_result
    game_result = self.game_result || build_game_result # Try to find an existing GameResult or build a new one
    game_result.draws = player_game_results.where(draw: true).count
    game_result.winners_by_draws = player_game_results.where(win_by_draw: true).count

    # Find the PlayerGameResult with the most points
    winning_result = player_game_results.order(points: :desc).first

    # Set the winner attribute to the name (or some identifier) of the winning player
    game_result.winner = winning_result.user.name if winning_result

    game_result.save
  end

  def assign_place
    self.player_game_results.order(points: :desc).each.with_index(1) do |player_game_result, index|
      player_game_result.update(place: index)
    end
  end

  private

  def set_week_number
    self.week_number = date.strftime('%U').to_i
    save
  end

  def assign_number_of_players
    update(number_of_players: player_game_results.count)
  end
end
