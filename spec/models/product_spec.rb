require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product_without_name) { build(:product, :product_with_image, name: nil) }
  let(:product_without_manufacturer) { build(:product, :product_with_image, manufacturer: nil) }
  let(:product_without_price) { build(:product, :product_with_image, price: nil) } 
  let(:product_without_integer_price) { build(:product, :product_with_image, price: 100.1) }  
  let(:product_wiht_zero_price) { build(:product, :product_with_image, price: 0) }
  let(:product_with_long_description) { build(:product, :product_with_image, description: "a" * 141) }  
  let(:product_without_image) { build(:product) }   
  
  describe "validations" do  
    it "商品名がない場合、無効であること" do
      product_without_name.valid?
      expect(product_without_name.errors[:name]).to include("を入力してください")
    end
   
    it "製造メーカーがない場合、無効であること" do
      product_without_manufacturer.valid?
      expect(product_without_manufacturer.errors[:manufacturer]).to include("を入力してください")
    end
        
    it "価格がない場合、無効であること" do
      product_without_price.valid?
      expect(product_without_price.errors[:price]).to include("を入力してください")
    end
  
    it "価格が整数でない場合、無効であること" do
      product_without_integer_price.valid?
      expect(product_without_integer_price.errors[:price]).to include("は整数で入力してください")
    end
 
    it "価格がゼロの場合、無効であること" do
      product_wiht_zero_price.valid?
      expect(product_wiht_zero_price.errors[:price]).to include("は0より大きい値にしてください")
    end
   
    it "商品説明が141文字以上の場合、無効であること" do
      product_with_long_description.valid?
      expect(product_with_long_description.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "画像がない場合、無効であること" do
      product_without_image.valid?
      expect(product_without_image.errors[:image]).to include("を入力してください")
    end
  end
end
