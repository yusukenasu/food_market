require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "associations" do
    let(:user) { create(:user) }
    let(:product) { create(:product) }

    it "イイねがユーザーに属する形で関連づけられていること" do
      association = Favorite.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it "イイねが商品に属する形で関連づけられていること" do
      association = Favorite.reflect_on_association(:product)
      expect(association.macro).to eq :belongs_to
    end
  end
end
