require 'rails_helper'

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
      it "ログインが完了すること" do
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
      it "ログインが完了すること" do
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
      it "ログアウトが完了すること" do
        expect(page).to have_content "ログアウトしました。"
      end
    end
  end

  describe "ユーザープロフィール編集" do
    let!(:user) { create(:user, name: "編集前の名前", profile: "編集前のプロフィールです。") }

    before do
      login_as(user, scope: :user)
      visit users_edit_profile_path
    end

    context "名前を編集した場合" do
      before do
        fill_in "名前", with: "編集後の名前"
        click_button "更新" 
      end
      it "名前の編集が完了すること" do
        expect(page).to have_content("編集後の名前")
      end
    end

    context "プロフィールを編集した場合" do
      before do
        fill_in "プロフィール", with: "編集後のプロフィールです。"
        click_button "更新"
      end
      it "プロフィールの編集が完了すること" do
        expect(page).to have_content("編集後のプロフィールです。")
      end
    end

    context "名前とプロフィールを編集した場合" do
      before do
        fill_in "名前", with: "編集後の名前"
        fill_in "プロフィール", with: "編集後のプロフィールです。"
        click_button "更新"
      end
      it "名前とプロフィールの編集が完了すること" do
        expect(page).to have_content("編集後の名前")
        expect(page).to have_content("編集後のプロフィールです。")
      end
    end

    context "アイコン画像を編集した場合" do
      before do
        attach_file "アイコン画像", 'spec/fixtures/user_image_after.png'
        click_button "更新"
      end
      it "アイコン画像の編集が完了すること" do
        expect(page).to have_css("img[src*='user_image_after.png']")
      end
    end  
  end

  describe "ユーザー設定変更" do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit edit_user_registration_path
    end

    context "メールアドレスを変更した場合" do
      before do
        fill_in "メールアドレス", with: "new_address@example.com"
        fill_in "現在のパスワード", with: "123456"
        click_button "更新"
      end
      it "メールアドレスの変更が完了すること" do
        visit users_home_path
        expect(page).to have_content "new_address@example.com"
      end
    end

    context "パスワードを変更した場合" do
      before do
        fill_in "新しいパスワード", with: "new_password"
        fill_in "新しいパスワード（確認）", with: "new_password"
        fill_in "現在のパスワード", with: "123456"
        click_button "更新"
      end
      it "パスワードの変更が完了すること" do
        expect(page).to have_content "アカウント情報を変更しました。"
      end
    end
  end

  describe "ユーザーアカウント削除" do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      click_button "削除"
    end
    it "アカウント削除が完了すること" do
      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
    end   
  end

  describe "パスワード再設定" do
    let!(:user) { create(:user, email: "pw_restet_test@example.com") }

    context "パスワード変更用のメールが送信されるまでの処理" do
      before do
        visit new_user_session_path
        click_link "※パスワードを忘れた場合はこちら"
        fill_in "メールアドレス", with: "pw_restet_test@example.com"
        click_button "送信"
      end
      it "パスワードの再設定用メールの送信が完了すること" do
        expect(page).to have_content "パスワードの再設定について数分以内にメールでご連絡いたします。"
      end
    end
  end
end
