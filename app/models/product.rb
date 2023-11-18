class Product < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :description, length: {maximum: 200}
  validates :point_of_reasonability, presence: true, numericality: { in: 1..5 }
  validates :point_of_impression, presence: true, numericality: { in: 1..5 }
  validates :point_of_taste, presence: true, numericality: { in: 1..5 }
  validates :point_of_repeatability, presence: true, numericality: { in: 1..5 }
  validates :point_of_design, presence: true, numericality: { in: 1..5 }
            
  def self.looks(word)
    @searched_products = Product.where("name LIKE?","%#{word}%")
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
