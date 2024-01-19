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

  def user_rank(user_id)
    product_id = Product.where(user_id: user_id)
    number = Favorite.where(product_id: product_id)
    ranks = [
      "初心者開発者",
      "未熟な開発者",
      "新進気鋭の開発者",
      "フードアンバサダー",
      "グルメ研究生",
      "フードクリエイター",
      "フードマイスター",
      "レシピメイカー",
      "フードアーティスト",
      "グルメプロデューサ",
      "中堅開発者",
      "グルメガイド",
      "フードコンシェル",
      "グルメマエストロ",
      "フードウィザード",
      "食のコーディネータ",
      "食のスペシャリスト",
      "グルメレジェンド",
      "フードエキスパート",
      "一流開発者",
      "食の達人開発者",
      "フードゴッド"
    ]
    return ranks[number.count] || "フードゴッド"
  end
end
