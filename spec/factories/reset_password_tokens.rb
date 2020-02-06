FactoryBot.define do
  factory :reset_password_token do
    user
    body { Faker::Lorem.word }
    used { false }

    trait :not_expired do
      created_at { DateTime.current }
    end

    trait :expired do
      created_at { ResetPasswordToken.max_age - 10.days }
    end

    trait :active do
      not_expired
      used { false }
    end
  end
end
