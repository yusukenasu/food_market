FactoryBot.define do
  factory :product do
    name { "MyString" }
    manufacturer { "MyString" }
    price { 100 }
    category { "MyString" }
    description { "MyString" }
    point_of_reasonability { 1 }
    point_of_impression { 1 }
    point_of_taste { 1 }
    point_of_repeatability { 1 }
    point_of_design { 1 }
    after(:build) do |product|
      product.image.attach(io: File.open('spec/fixtures/product_image.jpeg'), filename: 'product_image.jpeg', content_type: 'image/jpeg')
    end
    association :user
  end
end
