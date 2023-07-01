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
  has_many :player_match_results
end
