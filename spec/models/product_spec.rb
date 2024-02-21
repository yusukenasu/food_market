require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    # 商品名が無い場合、無効であること
    it "is invalid without a name" do
      product = FactoryBot.build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    # 製造メーカーが無い場合、無効であること
    it "is invalid without a manufacturer" do
      product = FactoryBot.build(:product, manufacturer: nil)
      product.valid?
      expect(product.errors[:manufacturer]).to include("を入力してください")
    end

    # 価格が無い場合、無効であること
    it "is invalid without a price" do
      product = FactoryBot.build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    # 価格が整数の場合、有効であること
    it "is valid with a valid price" do
      product = FactoryBot.build(:product)
      expect(product).to be_valid
    end

    # 価格が整数でない場合、無効であること
    it "is invalid without a non-integer price" do
      product = FactoryBot.build(:product, price: 100.1)
      expect(product).not_to be_valid
    end

    # 価格が0の場合、無効であること
    it "is invalid with a price equal to 0" do
      product = FactoryBot.build(:product, price: 0)
      expect(product).not_to be_valid
    end

    # 価格が0未満の場合、無効であること
    it "is invalid with a price less than 0" do
      product = FactoryBot.build(:product, price: -100)
      expect(product).not_to be_valid
    end

    # 商品説明が141文字以上で無効であること
    it "is invalid with over 141 characters in the description" do
      description_max_letters = "a" * 141
      product = FactoryBot.build(:product, description: description_max_letters )
      product.valid?
      expect(product.errors[:description]).to include("は140文字以内で入力してください")
    end

    # 商品画像がない場合、無効であること
    it "is invalid with an image" do
      product = FactoryBot.build(:product)
      product.image = nil
      product.valid?
      expect(product.errors[:image]).to include("を入力してください")
    end

    # リピート性の得点が無い場合、無効であること
    it "is invalid without a point_of_reasonability" do
      product = FactoryBot.build(:product, point_of_reasonability: nil)
      product.valid?
      expect(product.errors[:point_of_reasonability]).to include("を入力してください")
    end

    # 特徴的の得点が無い場合、無効であること
    it "is invalid without a point_of_impression" do
      product = FactoryBot.build(:product, point_of_impression: nil)
      product.valid?
      expect(product.errors[:point_of_impression]).to include("を入力してください")
    end

    # 味の得点が無い場合、無効であること
    it "is invalid without a point_of_taste" do
      product = FactoryBot.build(:product, point_of_taste: nil)
      product.valid?
      expect(product.errors[:point_of_taste]).to include("を入力してください")
    end

    # リピート性の得点が無い場合、無効であること
    it "is invalid without a point_of_repeatability" do
      product = FactoryBot.build(:product, point_of_repeatability: nil)
      product.valid?
      expect(product.errors[:point_of_repeatability]).to include("を入力してください")
    end

    # デザイン性の得点が無い場合、無効であること
    it "is invalid without a point_of_design" do
      product = FactoryBot.build(:product, point_of_design: nil)
      product.valid?
      expect(product.errors[:point_of_design]).to include("を入力してください")
    end
  end
end
