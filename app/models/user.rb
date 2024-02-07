class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, length: {maximum: 40}

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲスト'
      user.profile = 'ゲストとしてログインしています。'
    end
  end
end
