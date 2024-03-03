require 'rails_helper'

RSpec.describe "Products", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  describe "商品情報の登録" do
    let!(:user) { create(:user) }
   
    before do
      login_as(user, scope: :user)
      visit products_path
      click_link "商品情報を登録する"
      fill_in "商品名 ※", with: "new_product_name"
      fill_in "製造メーカー ※", with: "new_product_manufacturer"
      fill_in "円・価格（税込） ※", with: "200"
      fill_in "カテゴリー", with: "new_product_category"
      fill_in "商品の評価", with: "new_product_description"
      attach_file "商品画像 ※", 'spec/fixtures/product_image_1.jpeg'
      select "1", from: "コスパ ※"
      select "2", from: "特徴的 ※"
      select "3", from: "味 ※"
      select "4", from: "リピート性 ※"
      select "5", from: "デザイン性 ※"
      click_button "登録する"
    end

    it "登録完了後、商品詳細ページに遷移すること" do
      new_product = Product.last
      expect(current_path).to eq(product_path(new_product))
    end

    it "登録された商品情報が表示されること" do
      expect(page).to have_content "new_product_name"
      expect(page).to have_content "new_product_manufacturer"
      expect(page).to have_content "200"
      expect(page).to have_content "new_product_category"
      expect(page).to have_content "new_product_description"
      expect(page).to have_selector("img[src*='product_image_1.jpeg']")
      expect(page).to have_content "コスパ★☆☆☆☆"
      expect(page).to have_content "特徴的★★☆☆☆"
      expect(page).to have_content "味★★★☆☆"
      expect(page).to have_content "リピート性★★★★☆"
      expect(page).to have_content "デザイン性★★★★★"
    end
  end

  describe "商品詳細画面の表示" do
    let!(:user) { create(:user) }
    let(:product) { create(:product, :product_with_image) }

    before do
      login_as(user, scope: :user)
      visit product_path(product)
    end

    it "商品情報が表示されること" do
      expect(page).to have_content "product_name"
      expect(page).to have_content "product_manufacturer"
      expect(page).to have_content "100"
      expect(page).to have_content "product_category"
      expect(page).to have_selector("img[src*='product_image_1.jpeg']")
    end

    it "商品評価、レーダーチャートが表示されること" do
      expect(page).to have_css("canvas#myChart")
      expect(page).to have_content "コスパ★★★★★"
      expect(page).to have_content "特徴的★★★★☆"
      expect(page).to have_content "味★★★☆☆"
      expect(page).to have_content "リピート性★★☆☆☆"
      expect(page).to have_content "デザイン性★☆☆☆☆"
    end
    
    it "商品投稿者情報、商品説明が表示されること" do
      save_and_open_page
      expect(page).to have_css(".contributor_user_rank")
      expect(page).to have_content "test_name"
      expect(page).to have_selector("img[src*='user_image_before.png']")
      expect(page).to have_content "product_description"
    end
  end

  describe "商品詳細ページの関連商品" do
    let!(:user) { create(:user) }
   
    before do
      login_as(user, scope: :user)
    end

    context "関連商品が存在する場合" do
      before do
        visit new_product_path
        fill_in "商品名 ※", with: "マヨネーズ"
        fill_in "製造メーカー ※", with: "キューピー"
        fill_in "円・価格（税込） ※", with: "200"
        attach_file "商品画像 ※", 'spec/fixtures/product_image_1.jpeg'
        select "1", from: "コスパ ※"
        select "2", from: "特徴的 ※"
        select "3", from: "味 ※"
        select "4", from: "リピート性 ※"
        select "5", from: "デザイン性 ※"
        click_button "登録する"
      end

      it "関連商品の名前、画像、価格が表示されること" do
        expect(page).to have_css(".item_name")
        expect(page).to have_css(".item_image")
        expect(page).to have_css(".item_price")
      end

      it "関連商品が4つ表示されること" do
        all_related_items = page.all(".item_container")

        expect(all_related_items.count).to eq 4
      end
    end

    context "関連商品が存在しない場合" do      
      let!(:product) { create(:product, :product_with_image) }

      it "関連商品が表示されないこと" do
        visit product_path(product)
        expect(page).to have_content("※関連商品は見つかりませんでした。")
      end
    end
  end


  describe "登録商品の編集" do
  end
  
  describe "登録商品の削除" do
  end

  describe "商品検索" do
  end
  
  describe "ファーストビューでの商品画像表示" do
    context "5つの商品が登録されている場合" do
      let!(:products) do
        products = build_list(:product, 5)
        products.each_with_index do |product, index|
          product.image.attach(io: File.open("spec/fixtures/product_image_#{index+1}.jpeg"), filename: "product_image_#{index+1}.jpeg", content_type: 'image/jpeg')
          product.save
        end
      end

      it "商品画像が4つ表示されていること" do
        visit products_path
        all_product_images = page.all(".firstview_product_image")

        expect(all_product_images.count).to eq 4
      end
    end

    context "3つの商品が登録されている場合" do
      let!(:products) do
        products = build_list(:product, 3)
        products.each_with_index do |product, index|
          product.image.attach(io: File.open("spec/fixtures/product_image_#{index+1}.jpeg"), filename: "product_image_#{index+1}.jpeg", content_type: 'image/jpeg')
          product.save
        end
      end
      
      it "商品画像が3つ表示されていること" do
        visit products_path
        all_product_images = page.all(".firstview_product_image")

        expect(all_product_images.count).to eq 3
      end
    end
  end

  describe "" do
  end
end