require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    # ファクトリが有効であること
    it "is valid with a factory" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    # 名前がない場合、無効であること
    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    # パスワードがない場合、無効であること
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # パスワードが５文字以下の場合、無効であること
    it "is invalid without a password less than 5 charactors " do
      user = FactoryBot.build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    
    # メールアドレスがない場合、無効であること
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # 重複したメールアドレスの場合無効であること
    it "is invalid with a duplicate email" do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # プロフィールが41文字以上で無効であること
    it "is invalid with over 41 characters in the profile" do
      profile_max_letters = "a" * 41
      user = FactoryBot.build(:user, profile: profile_max_letters )
      user.valid?
      expect(user.errors[:profile]).to include("は40文字以内で入力してください")
    end
  end
end
