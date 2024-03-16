require 'rails_helper'

RSpec.describe "Rakuten API", type: :request do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :product_with_image, user:) }

  before do
    login_as(user, scope: :user)
    get product_path(product)
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_successful
    expect(response).to have_http_status "200"
  end

  it "レスポンスのHTMLに関連商品の画像、価格、リンクが含まれていること" do
    @items = RakutenWebService::Ichiba::Item.search(keyword: "#{product.name} #{product.manufacturer}").first(4)
    @items.each do |item|
      expect(response.body).to include(item['smallImageUrls'][0])
      expect(response.body).to include(item.price.to_s)
      expect(response.body).to include(item.name)
      expect(response.body).to include(item.url)
    end
  end
end
