FactoryBot.define do
  factory :product do
    name { "product0_name" }
    manufacturer { "product0_manufacturer" }
    price { 100 }
    category { "product_category" }
    description { "product_description" }
    point_of_reasonability { 5 }
    point_of_impression { 4 }
    point_of_taste { 3 }
    point_of_repeatability { 2 }
    point_of_design { 1 }
    association :user

    trait :product_with_image do
      after(:build) do |product|
        product.image.attach(io: File.open('spec/fixtures/product_image_0.jpeg'), filename: 'product_image_0.jpeg', content_type: 'image/jpeg')
      end
    end
  end
end
