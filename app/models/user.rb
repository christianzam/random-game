# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  interest               :jsonb
#  last_name              :string
#  name                   :string
#  nick_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :player_game_results, dependent: :destroy

  has_one_attached :profile_pic
  
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }
  validates :nick_name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 15 }, presence: true
  validates :last_name, length: { minimum: 2, maximum: 15 }

  def full_name
    "#{name} #{last_name}"
  end

  def score_avrg
    return 0 if self.player_game_results.blank?
  
    total_points = self.player_game_results.sum(:points)
    total_games = self.player_game_results.joins(:game).size
  
    return 0 if total_games.zero?
  
    (total_points.to_f / total_games) * 10
  end

  def games_played
    self.player_game_results.size
  end

  def ranking
    user_results = self.player_game_results.joins(:game).sum(:points)
    # Determine the place based on the total points
    PlayerGameResult.joins(:game)
                     .where('points > ?', user_results)
                     .order(points: :desc)
                     .count + 1
  end
end
