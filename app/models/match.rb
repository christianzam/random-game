# == Schema Information
#
# Table name: matches
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Match < ApplicationRecord
  has_many :player_match_results, dependent: :destroy
  has_many :users, through: :player_match_results
  accepts_nested_attributes_for :player_match_results

  def submitted_users
    puts '11111111111111111111'
    users.pluck(:id)
  end
end
