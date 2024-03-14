require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:user_without_name) { build(:user, name: nil) }
  let(:user_without_password) { build(:user, password: nil) }
  let(:user_with_short_password) { build(:user, password: "12345") }
  let(:user_without_email) { build(:user, email: nil) }
  let(:another_user) { build(:user, email: user.email) }
  let(:user_with_long_profile) { build(:user, profile: "a" * 41) }

  describe "validations" do
    it "ファクトリが有効であること" do
      expect(user).to be_valid
    end

    it "名前がない場合、無効であること" do
      user_without_name.valid?
      expect(user_without_name.errors[:name]).to include("を入力してください")
    end

    it "パスワードがない場合、無効であること" do
      user_without_password.valid?
      expect(user_without_password.errors[:password]).to include("を入力してください")
    end

    it "パスワードが５文字以下の場合、無効であること" do
      user_with_short_password.valid?
      expect(user_with_short_password.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "メールアドレスがない場合、無効であること" do
      user_without_email.valid?
      expect(user_without_email.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスの場合無効であること" do
      user.save
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "プロフィールが41文字以上で無効であること" do
      user_with_long_profile.valid?
      expect(user_with_long_profile.errors[:profile]).to include("は40文字以内で入力してください")
    end
  end
end
