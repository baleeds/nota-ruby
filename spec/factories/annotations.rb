# frozen_string_literal: true

FactoryBot.define do
  factory :annotation do
    text { Faker::Lorem.paragraph(sentence_count: 10) }
    user
    verse
  end
end
