# == Schema Information
#
# Table name: matches
#
#  id            :bigint           not null, primary key
#  date          :date
#  day_number    :integer
#  players_count :integer          default(0)
#  week_number   :integer
#  winner        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Match < ApplicationRecord
  has_many :player_match_results, dependent: :destroy
  has_many :users, through: :player_match_results
  accepts_nested_attributes_for :player_match_results

  after_create :set_week_number

  def submitted_users
    users.pluck(:id)
  end

  def set_week_number
    self.week_number = date.strftime('%U').to_i
    save
  end
end
