RSpec.describe "ユーザーページ", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "ユーザー新規登録" do
    context "リンクから新規登録する場合" do
      before do
        visit products_path
        within ".firstview_registration_message" do
          click_link "新規登録"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "名前", with: "test"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        click_button "登録"
      end
      it "ユーザー登録が完了すること" do
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "ボタンから新規登録する場合" do
      before do
        visit products_path
        within ".firstview_loggedout_buttons_container" do
          click_link "新規登録"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "名前", with: "test"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        click_button "登録"
      end
      it "ユーザー登録が完了すること" do
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end
  end 

  describe "ユーザーログイン・ログアウト" do
    let!(:user) { create(:user, email: "test@example.com", password: "password") }
    
    context "リンクからログインする場合" do
      before do
        visit products_path
        within ".firstview_registration_message" do
          click_link "ログイン"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "ユーザーログインが完了すること" do
        expect(page).to have_content "ログインしました。"
      end
    end

    context "ボタンからログインする場合" do
      before do
        visit products_path
        within ".firstview_upper_container" do
          click_link "ログイン"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "ユーザーログインが完了すること" do
        expect(page).to have_content "ログインしました。"
      end
    end

    context "ログアウトする場合" do
      before do
        login_as(user, scope: :user)
        visit products_path
        within ".dropdown-menu" do
          click_link "ログアウト" 
        end
      end
      it "ユーザーがログアウトすること" do
        expect(page).to have_content "ログアウトしました。"
      end
    end
  end

  describe "ユーザープロフィール編集" do
  end

  describe "ユーザー設定変更" do
  end

  describe "ユーザーアカウント削除" do
  end

  describe "パスワード再設定" do
  end
end
