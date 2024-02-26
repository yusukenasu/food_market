FactoryBot.define do
  factory :user do
    name {"test"}
    sequence (:email) { |n| "test#{n}@example.com" }
    password {"123456"}
    profile {"test"}
    after(:build) do |user|
      user.image.attach(io: File.open('spec/fixtures/user_image_before.png'), filename: 'user_image_before.png', content_type: 'image/png')
    end
  end
end
