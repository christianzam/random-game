# == Schema Information
#
# Table name: weekly_scores
#
#  id           :bigint           not null, primary key
#  place        :integer          default(0)
#  total_points :integer          default(0)
#  week_number  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_weekly_scores_on_user_id_and_week_number  (user_id,week_number) UNIQUE
#
class WeeklyScore < ApplicationRecord
  belongs_to :user

end
