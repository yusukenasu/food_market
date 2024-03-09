class Product < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :description, length: {maximum: 140}
  validates :image, presence: true
  
  def self.looks(word)
    where("name LIKE(?) OR manufacturer LIKE(?)" , "%#{word}%", "%#{word}%")
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
