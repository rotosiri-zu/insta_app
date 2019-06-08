FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:user_name) { |n| "user_name#{n}" }
    sequence(:email) { |n| "test#{n}@mail.com" }
    password { "password" }
  end
end
