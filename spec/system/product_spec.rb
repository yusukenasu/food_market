require 'rails_helper'

RSpec.describe "Products", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  describe "商品情報の登録" do
    let(:user) { create(:user) }
    
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
    it "商品登録が完了すること" do
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

  describe "商品詳細の表示" do
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