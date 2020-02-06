require "factory_bot_rails"
require "faker"

tech = User.create(
  email: "development@level.tech",
  password: "Tester12",
  admin: true
)

User.create(
  email: "development@level.bz",
  password: "Tester12",
  admin: false
)

FactoryBot.create_list(
  :book,
  50,
  authors: Faker::Book.author,
  description: Faker::Lorem.paragraph(sentence_count: 10),
  image_url: "http://books.google.com/books/content?id=iXn5U2IzVH0C&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api",
  page_count: rand(100..300)
)

FactoryBot.create_list(
  :annotation,
  50,
  text: Faker::Lorem.paragraph(sentence_count: 10),
  verse_id: "01001001",
  user: tech
)