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
class PlayerGameResult < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user_id, uniqueness: { scope: :match_id }
  validate :points_not_nil

  after_create :assign_place

  def points_not_nil
    if points.nil?
      errors.add(:points, "no puede estar en blanco")
    end
  end

  private

  def assign_place
    if game.player_game_results.count == User.count
      self.update(points: self.points + 1) if self.draw == true
  
      ordered_results = game.player_match_results.order(points: :desc)
      ranked_results = ordered_results.rank(:points, with_same: :skip)
  
      ranked_results.each do |player_game_result|
        player_game_result.update(place: player_game_result.rank)
      end
    end
  end

end
