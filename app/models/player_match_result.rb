# == Schema Information
#
# Table name: player_match_results
#
#  id         :bigint           not null, primary key
#  draw       :boolean
#  place      :integer
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_player_match_results_on_match_id  (match_id)
#  index_player_match_results_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (user_id => users.id)
#
class PlayerMatchResult < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :user_id, uniqueness: { scope: :match_id }
  validate :points_not_nil

  after_create :assign_place
  after_create :update_weekly_score

  def points_not_nil
    if points.nil?
      errors.add(:points, "no puede estar en blanco")
    end
  end

  private

  def assign_place
    if match.player_match_results.count == User.count
      self.update(points: self.points + 1) if self.draw == true
  
      ordered_results = match.player_match_results.order(points: :desc)
      ranked_results = ordered_results.rank(:points, with_same: :skip)
  
      ranked_results.each do |player_match_result|
        player_match_result.update(place: player_match_result.rank)
      end
    end
  end
  

  def update_weekly_score
    week_number = match.week_number
    weekly_score = user.weekly_scores.find_or_initialize_by(week_number: week_number)
    weekly_score.total_points = user.player_match_results.joins(:match).where('matches.week_number = ?', week_number).sum(:points)
    weekly_score.save
  end
end
