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

  def amount_of_favorites_with_product(productid)
    number = Favorite.where(product_id: productid)
    return number.count
  end
end
