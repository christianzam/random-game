class PlayerStat < ApplicationRecord
  belongs_to :user
  has_many :match_stats
end
