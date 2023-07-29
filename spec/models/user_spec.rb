require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    let(:user) { create(:user) }
      
      it "ファクトリが有効であること" do
        expect(user).to be_valid
      end

      it "名前がない場合、無効であること" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "パスワードがない場合、無効であること" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "メールアドレスがない場合、無効であること" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "重複したメールアドレスの場合無効であること" do
        user.save
        another_user = FactoryBot.build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "プロフィールが41文字以上で無効であること" do
        profile_max_letters = "a" * 41
        user = FactoryBot.build(:user, profile: profile_max_letters )
        user.valid?
        expect(user.errors[:profile]).to include("は40文字以内で入力してください")
      end
  end
end
