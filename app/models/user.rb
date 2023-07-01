class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :player_stat, dependent: :destroy
  has_many :match_stats, dependent: :destroy
  
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }
  validates :nick_name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 15 }, presence: true
  validates :last_name, length: { minimum: 2, maximum: 15 }, presence: true

  def full_name
    "#{name} #{last_name}"
  end
end
