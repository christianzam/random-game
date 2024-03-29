# == Schema Information
#
# Table name: weekly_results
#
#  id            :bigint           not null, primary key
#  matches_count :integer
#  place         :integer
#  total_points  :integer
#  week_number   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_weekly_results_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe WeeklyResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
