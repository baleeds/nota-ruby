FactoryBot.define do
  factory :verse do
    id { '01001001' }
    book_number { '1' }
    chapter_number { '1' }
    verse_number { '1' }
    text { Faker::Lorem.paragraph(sentence_count: 1) }
  end
end