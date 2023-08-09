FactoryBot.define do
  factory :product do
    name { "MyString" }
    manufacturer { "MyString" }
    price { 1 }
    category { "MyString" }
    description { "MyString" }
    point_of_reasonability { 1 }
    point_of_uniqueness { 1 }
    point_of_taste { 1 }
    point_of_repeatability { 1 }
    point_of_design { 1 }
  end
end
