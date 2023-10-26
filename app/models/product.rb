class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true

  def self.looks(word)
    @searched_products = Product.where("name LIKE?","%#{word}%")
  end
end
