FactoryBot.define do
  factory :user do
    name {"name"}
    user_name {"user_name"}
    sequence(:email) { |n| "test#{n}@mail.com" }
    password {"password"}
  end
end
