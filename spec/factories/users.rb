FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.email }
    display_name { Faker::Name.name }

    trait :admin do
      admin { true }
    end

    trait :active do
      active { true }
    end

    trait :suspended do
      active { false }
    end
  end
end
