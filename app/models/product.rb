class Product < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :description, length: {maximum: 140}
  validates :image, presence: true
  validates :point_of_reasonability, presence: true
  validates :point_of_impression, presence: true
  validates :point_of_taste, presence: true
  validates :point_of_repeatability, presence: true
  validates :point_of_design, presence: true
  
  def self.looks(word)
    where("name LIKE ? OR category LIKE ?", "%#{word}%", "%#{word}%")
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
