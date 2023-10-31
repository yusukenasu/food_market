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
end
