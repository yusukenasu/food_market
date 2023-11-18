module ApplicationHelper
  def item_score(score)
    star = ""
    score.times do 
      star += "★"
    end
    (5-score).times do
      star += "☆"
    end
    return star
  end

  def amount_of_favorites_with_product(product_id)
    number = Favorite.where(product_id: product_id)
    return number.count
  end

  def amount_of_favorites_with_user(user_id)
    product_id = Product.where(user_id: user_id)
    number = Favorite.where(product_id: product_id)
    return number.count
  end
end
