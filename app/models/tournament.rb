# == Schema Information
#
# Table name: tournaments
#
#  id                :bigint           not null, primary key
#  end_date          :date
#  name              :string
#  period_tournament :boolean
#  start_date        :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Tournament < ApplicationRecord
  has_many :games
  has_one_attached :tournament_picture

  validates :name, :start_date, :end_date, presence: true
end
