require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  describe "いいね機能", js: true do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, :product_with_image, user:) }
    let!(:another_user) { create(:user) }

    context "商品投稿者以外のユーザーがイイねする場合" do
      before do
        login_as(another_user, scope: :user)
        visit product_path(product)
      end

      it "登録商品のイイねが増えること" do
        expect(page).to have_content "★イイね 0"

        find(".favorite_button_off").click

        expect(page).to have_content "★イイね 1"
      end

      it "投稿者のユーザーランクが上がること" do
        expect(page).to have_content "初心者開発者(Lv.1)"

        find(".favorite_button_off").click
        visit product_path(product)

        expect(page).to have_content "未熟な開発者(Lv.2)"
      end
    end

    context "商品の投稿者以外のユーザーがイイねを外す場合" do
      before do
        login_as(another_user, scope: :user)
        visit product_path(product)
        find(".favorite_button_off").click
      end

      it "登録商品のイイねが減ること" do
        expect(page).to have_content "★イイね 1"

        find(".favorite_button_on").click

        expect(page).to have_content "★イイね 0"
      end

      it "投稿者のユーザーランクが下がること" do
        visit product_path(product)
        expect(page).to have_content "未熟な開発者(Lv.2)"

        find(".favorite_button_on").click
        visit product_path(product)

        expect(page).to have_content "初心者開発者(Lv.1)"
      end
    end

    context "投稿者自身が登録商品にイイねする場合" do
      before do
        login_as(user, scope: :user)
        visit product_path(product)
      end

      it "イイねボタンは無効でイイね数のみ表示されること" do
        expect(page).not_to have_css ".favorite_button_on"
        expect(page).not_to have_css ".favorite_button_off"
        expect(page).to have_css ".favorites_of_product"
      end
    end
  end
end
