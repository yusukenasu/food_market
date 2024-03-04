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
      expect(page).to have_selector "img[src*='product_image_1.jpeg']"
      expect(page).to have_content "コスパ★☆☆☆☆"
      expect(page).to have_content "特徴的★★☆☆☆"
      expect(page).to have_content "味★★★☆☆"
      expect(page).to have_content "リピート性★★★★☆"
      expect(page).to have_content "デザイン性★★★★★"
    end
  end

  describe "商品詳細画面の表示" do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, :product_with_image, user: user) }

    before do
      login_as(user, scope: :user)
      visit product_path(product)
    end

    it "商品情報が表示されること" do
      expect(page).to have_content "product_name"
      expect(page).to have_content "product_manufacturer"
      expect(page).to have_content "100"
      expect(page).to have_content "product_category"
      expect(page).to have_selector "img[src*='product_image_1.jpeg']"
    end

    it "商品評価、レーダーチャートが表示されること" do
      expect(page).to have_css "canvas#myChart"
      expect(page).to have_content "コスパ★★★★★"
      expect(page).to have_content "特徴的★★★★☆"
      expect(page).to have_content "味★★★☆☆"
      expect(page).to have_content "リピート性★★☆☆☆"
      expect(page).to have_content "デザイン性★☆☆☆☆"
    end
    
    it "商品投稿者情報、商品説明が表示されること" do
      expect(page).to have_content "#{user_rank(user.id)}"
      expect(page).to have_content "test_name"
      expect(page).to have_selector "img[src*='user_image_before.png']"
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
        expect(page).to have_css ".item_name"
        expect(page).to have_css ".item_image"
        expect(page).to have_css ".item_price"
      end

      it "関連商品が4つ表示されること" do
        all_related_items = page.all ".item_container"

        expect(all_related_items.count).to eq 4
      end
    end

    context "関連商品が存在しない場合" do      
      let!(:product) { create(:product, :product_with_image) }

      it "関連商品が表示されないこと" do
        visit product_path(product)
        expect(page).to have_content "※関連商品は見つかりませんでした。"
      end
    end
  end


  describe "登録商品の編集" do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, :product_with_image, user: user) }

    before do
      login_as(user, scope: :user)
      visit users_home_path
      click_button "編集"
      fill_in "商品名 ※", with: "編集後の商品名"
      fill_in "製造メーカー ※", with: "編集後の製造メーカー"
      fill_in "円・価格（税込） ※", with: "200"
      fill_in "カテゴリー", with: "編集後のカテゴリー"
      fill_in "商品の評価", with: "編集後の評価"
      attach_file "商品画像 ※", 'spec/fixtures/product_image_2.jpeg'
      select "2", from: "コスパ ※"
      select "3", from: "特徴的 ※"
      select "4", from: "味 ※"
      select "5", from: "リピート性 ※"
      select "1", from: "デザイン性 ※"
      click_button "登録する"
    end

    it "商品情報の編集が完了すること" do      
      expect(page).to have_content "編集後の商品名"
      expect(page).to have_content "編集後の製造メーカー"
      expect(page).to have_content "200"
      expect(page).to have_content "編集後のカテゴリー"
      expect(page).to have_selector "img[src*='product_image_2.jpeg']"
      expect(page).to have_content "コスパ★★☆☆☆"
      expect(page).to have_content "特徴的★★★☆☆"
      expect(page).to have_content "味★★★★☆"
      expect(page).to have_content "リピート性★★★★★"
      expect(page).to have_content "デザイン性★☆☆☆☆"
    end
  end
  
  describe "登録商品の削除" do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, :product_with_image, user: user) }

    before do
      login_as(user, scope: :user)
      visit users_home_path
    end

    it "登録商品が存在すること" do
      expect(page).to have_content "product_name"
      expect(page).to have_selector "img[src*='product_image_1.jpeg']"
    end

    it "登録商品の削除が完了すること" do
      click_button "削除"

      expect(page).not_to have_content "product_name"
      expect(page).not_to have_selector "img[src*='product_image_1.jpeg']"
    end
  end

  describe "ログイン状態での商品検索" do
    let!(:user) { create(:user) }
    let!(:products) do
      products = build_list(:product, 3, user: user)
      products.each_with_index do |product, index|
        product.name = "product#{index+1}_name"
        product.manufacturer = "product#{index+1}_manufacturer"
        product.image.attach(io: File.open("spec/fixtures/product_image_#{index+1}.jpeg"), filename: "product_image_#{index+1}.jpeg", content_type: 'image/jpeg')
        product.save
      end
    end

    context "ヘッダー検索ボタンをクリックした場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".search_form" do
          click_button "検索"
        end
      end

      it "検索結果画面に遷移すること" do
        expect(current_path).to eq(products_search_path)
      end
    end

    context "ページ中央の検索ボタンをクリックした場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".firstview_search_form" do
          click_button "検索"
        end
      end

      it "検索結果画面に遷移すること" do
        expect(current_path).to eq(products_search_path)
      end
    end

    context "検索ワードなしで検索した場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".search_form" do
          click_button "検索"
        end
      end

      it "ヒット件数が表示されること" do
        expect(page).to have_content "3件の商品が見つかりました。"
      end

      it "ヒットしたすべての商品が表示されること" do
        expect(page).to have_content "product1_name"
        expect(page).to have_content "product2_name"
        expect(page).to have_content "product3_name"
      end
    end

    context "商品名を入力して検索した場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".search_form" do
          fill_in "word", with: "product1_name"
          click_button "検索"
        end
      end

      it "ヒットした商品情報のみが表示されること" do
        expect(page).to have_content "product1_name"
        expect(page).to have_content "product1_manufacturer"
        expect(page).to have_selector "img[src*='product_image_1.jpeg']"
        expect(page).not_to have_content "product2_name"
        expect(page).not_to have_content "product2_manufacturer"
        expect(page).not_to have_selector "img[src*='product_image_2.jpeg']"
        expect(page).not_to have_content "product3_name"
        expect(page).not_to have_content "product3_manufacturer"
        expect(page).not_to have_selector "img[src*='product_image_3.jpeg']"
      end
    end

    context "製造メーカーを入力して検索した場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".search_form" do
          fill_in "word", with: "product2_manufacturer"
          click_button "検索"
        end
      end

      it "ヒットした商品情報が表示されること" do
        expect(page).to have_content "product2_name"
        expect(page).to have_content "product2_manufacturer"
        expect(page).to have_selector "img[src*='product_image_2.jpeg']"
        expect(page).not_to have_content "product1_name"
        expect(page).not_to have_content "product1_manufacturer"
        expect(page).not_to have_selector "img[src*='product_image_1.jpeg']"
        expect(page).not_to have_content "product3_name"
        expect(page).not_to have_content "product3_manufacturer"
        expect(page).not_to have_selector "img[src*='product_image_3.jpeg']"
      end
    end

    context "存在しない商品を検索した場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".search_form" do
          fill_in "word", with: "product4_name"
          click_button "検索"
        end
      end

      it "商品が見つからないこと" do
        expect(page).to have_content "商品が見つかりませんでした。"
      end
    end
  end

  describe "ログアウト状態での商品検索" do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, :product_with_image, user: user) }

    before do
      visit products_path
      within ".search_form" do
        click_button "検索"
      end
    end

    it "商品評価が表示されていないこと" do
      expect(page).not_to have_content "product_description"
    end

    it "新規登録、ログインへの誘導メッセージが表示されていること" do
      expect(page).to have_content "新規登録または ログインして商品情報を確認しよう！"
    end

    it "新規登録画面に遷移すること" do
      click_link "新規登録" 
      expect(current_path).to eq(new_user_registration_path)
    end

    it "ログイン画面に遷移すること" do
      click_link "ログイン"
      expect(current_path).to eq(new_user_session_path)
    end
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
        all_product_images = page.all ".firstview_product_image"

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
        all_product_images = page.all ".firstview_product_image"

        expect(all_product_images.count).to eq 3
      end
    end
  end
end