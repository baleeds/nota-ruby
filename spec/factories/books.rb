FactoryBot.define do
  factory :book do
    title { Faker::Book.unique.title }
  end
end
