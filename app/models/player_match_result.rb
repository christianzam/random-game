# == Schema Information
#
# Table name: player_match_results
#
#  id         :bigint           not null, primary key
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
end
