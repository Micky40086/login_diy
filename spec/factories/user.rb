FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "mickey#{n}@example.com" }
    sequence(:name) { |n| "mickey#{n}" }
    password { "00000000" }
  end
end
