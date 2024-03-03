require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    context "商品名が未入力の場合" do
      let(:product) { build(:product, :product_with_image, name: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end
    end

    context "製造メーカーが未入力の場合" do
      let(:product) { build(:product, :product_with_image, manufacturer: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:manufacturer]).to include("を入力してください")
      end
    end

    context "価格が未入力の場合" do
      let(:product) { build(:product, :product_with_image, price: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end
    end

    context "整数でない価格が入力された場合" do
      let(:product) { build(:product, :product_with_image, price: 100.1) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:price]).to include("は整数で入力してください")
      end
    end

    context "価格が0と入力された場合" do
      let(:product) { build(:product, :product_with_image, price: 0) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:price]).to include("は0より大きい値にしてください")
      end
    end

    context "商品説明が141文字以上入力された場合" do
      description_max_letters = "a" * 141
      let(:product) { build(:product, :product_with_image, description: description_max_letters) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:description]).to include("は140文字以内で入力してください")
      end
    end

    context "商品画像が未選択の場合" do
      let(:product) { build(:product) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:image]).to include("を入力してください")
      end
    end

    context "リピート性が未入力の場合" do
      let(:product) { build(:product, :product_with_image, point_of_reasonability: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:point_of_reasonability]).to include("を入力してください")
      end
    end

    context "特徴的が未入力の場合" do
      let(:product) { build(:product, :product_with_image, point_of_impression: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:point_of_impression]).to include("を入力してください")
      end
    end

    context "味が未入力の場合" do
      let(:product) { build(:product, :product_with_image, point_of_taste: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:point_of_taste]).to include("を入力してください")
      end
    end

    context "リピート性が未入力の場合" do
      let(:product) { build(:product, :product_with_image, point_of_repeatability: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:point_of_repeatability]).to include("を入力してください")
      end
    end

    context "デザイン性が未入力の場合" do
      let(:product) { build(:product, :product_with_image, point_of_design: nil) }  
      it "商品が登録されないこと" do
        product.valid?
        expect(product.errors[:point_of_design]).to include("を入力してください")
      end
    end
  end
end
