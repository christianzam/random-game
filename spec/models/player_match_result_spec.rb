# == Schema Information
#
# Table name: player_match_results
#
#  id          :bigint           not null, primary key
#  draw        :boolean          default(FALSE)
#  draw_with   :string
#  place       :integer
#  points      :integer
#  win_by_draw :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  match_id    :bigint           not null
#  user_id     :bigint           not null
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
require 'rails_helper'

RSpec.describe PlayerMatchResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
