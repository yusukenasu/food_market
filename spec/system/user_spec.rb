require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:product) { create(:product, :product_with_image) }

  describe "ユーザー新規登録" do
    context "リンクから新規登録する場合" do
      it "ユーザー登録が完了すること" do
        visit products_path
        within ".firstview_registration_message" do
          click_link "新規登録"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "名前", with: "test"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        click_button "登録"
        
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "ボタンから新規登録する場合" do
      it "ユーザー登録が完了すること" do
        visit products_path
        within ".firstview_loggedout_buttons_container" do
          click_link "新規登録"
        end
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "名前", with: "test"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        click_button "登録"

        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end
  end 

  describe "ユーザーログイン・ログアウト" do    
    context "リンクからログインする場合" do
      it "ログインが完了すること" do
        visit products_path
        within ".firstview_registration_message" do
          click_link "ログイン"
        end
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"

        expect(page).to have_content "ログインしました。"
        expect(page).to have_content "#{user.name}"
        expect(page).to have_selector "img[src*='user_image_before.png']"
      end
    end

    context "ボタンからログインする場合" do
      it "ログインが完了すること" do
        visit products_path
        within ".firstview_upper_container" do
          click_link "ログイン"
        end
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"

        expect(page).to have_content "ログインしました。"
        expect(page).to have_content "#{user.name}"
        expect(page).to have_selector "img[src*='user_image_before.png']"
      end
    end

    context "ログアウトする場合" do
      it "ログアウトが完了すること" do
        login_as(user, scope: :user)
        visit products_path
        within ".dropdown-menu" do
          click_link "ログアウト" 
        end

        expect(page).to have_content "ログアウトしました。"
      end
    end
  end

  describe "ユーザープロフィール編集" do
    before do
      login_as(user, scope: :user)
      visit users_edit_profile_path
    end

    context "名前を編集した場合" do
      it "名前の編集が完了すること" do
        fill_in "名前", with: "編集後の名前"
        click_button "更新" 

        expect(page).to have_content "編集後の名前"
        expect(page).to have_content "#{user.profile}"
        expect(page).to have_selector("img[src*='user_image_before.png']")
      end
    end

    context "プロフィールを編集した場合" do
      it "プロフィールの編集が完了すること" do
        fill_in "プロフィール", with: "編集後のプロフィールです。"
        click_button "更新"

        expect(page).to have_content "#{user.name}"
        expect(page).to have_content "編集後のプロフィールです。"
        expect(page).to have_selector("img[src*='user_image_before.png']")
      end
    end

    context "名前とプロフィールを編集した場合" do
      it "名前とプロフィールの編集が完了すること" do
        fill_in "名前", with: "編集後の名前"
        fill_in "プロフィール", with: "編集後のプロフィールです。"
        click_button "更新"

        expect(page).to have_content "編集後の名前"
        expect(page).to have_content "編集後のプロフィールです。"
        expect(page).to have_selector("img[src*='user_image_before.png']")
      end
    end

    context "アイコン画像を編集した場合" do
      it "アイコン画像の編集が完了すること" do
        attach_file "アイコン画像", 'spec/fixtures/user_image_after.png'
        click_button "更新"

        expect(page).to have_content "#{user.name}"
        expect(page).to have_content "#{user.profile}"
        expect(page).to have_css("img[src*='user_image_after.png']")
      end
    end  
  end

  describe "ユーザー設定変更" do
    before do
      login_as(user, scope: :user)
      visit edit_user_registration_path
    end

    context "メールアドレスを変更した場合" do
      it "メールアドレスの変更が完了すること" do
        fill_in "メールアドレス", with: "new_address@example.com"
        fill_in "現在のパスワード", with: user.password
        click_button "更新"

        expect(page).to have_content "アカウント情報を変更しました。"

        visit users_home_path
        
        expect(page).to have_content "new_address@example.com"
      end
    end

    context "パスワードを変更した場合" do
      it "パスワードの変更が完了すること" do
        fill_in "パスワード", with: "new_password"
        fill_in "パスワード（確認）", with: "new_password"
        fill_in "現在のパスワード", with: user.password
        click_button "更新"

        expect(page).to have_content "アカウント情報を変更しました。"

        click_link "ログアウト"
        within ".firstview_upper_container" do
          click_link "ログイン"
        end
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "new_password"
        click_button "ログイン"

        expect(page).to have_content "ログインしました。"
      end
    end
  end

  describe "ユーザーアカウント削除" do
    it "アカウント削除が完了すること" do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      click_button "削除"

      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
    end   
  end

  describe "パスワード再設定" do
    it "パスワードの再設定用メールの送信が完了すること" do
      visit new_user_session_path
      click_link "※パスワードを忘れた場合はこちら"
      fill_in "メールアドレス", with: user.email
      click_button "送信"

      expect(page).to have_content "パスワードの再設定について数分以内にメールでご連絡いたします。"

      mail = ActionMailer::Base.deliveries.last
      reset_password_url = mail.body.to_s.match(/http:\/\/[^"]+/)[0]
      visit reset_password_url

      expect(page).to have_content "パスワードの再設定"

      fill_in "パスワード", with: "new_password"
      fill_in "パスワード（確認）", with: "new_password"
      click_button "パスワードを変更"

      expect(page).to have_content "パスワードが正しく変更されました。"
    end
  end

  describe "ゲストログイン" do
    context "リンクからゲストログインする場合" do
      it "ゲストログインが完了すること" do
        visit products_path
        click_link "こちら"

        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end   
    end

    context "ボタンからゲストログインする場合" do
      it "ゲストログインが完了すること" do
        visit products_path
        click_link "ゲストログイン"

        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end   
    end
  end
end
