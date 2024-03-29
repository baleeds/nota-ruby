# frozen_string_literal: true

require 'factory_bot_rails'
require 'faker'
require 'csv'

ben = User.create(
  email: 'b.a.leeds@gmail.com',
  password: 'Tester12',
  username: 'ben',
  display_name: 'Ben Leeds',
  admin: true
)

erica = User.create(
  email: 'ericapleeds@gmail.com',
  password: 'Tester12',
  username: 'erica',
  display_name: 'Erica Leeds',
  admin: false
)

csv_text = File.read(Rails.root.join('db', 'assets', 't_web.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
# Only take the first 100 for testing purposes
csv[0..100].each do |row|
  t = Verse.new
  t.id = row['id']
  t.book_number = row['b']
  t.chapter_number = row['c']
  t.verse_number = row['v']
  t.text = row['t']
  t.save
end

verse = Verse.find('1001001')

FactoryBot.create_list(
  :annotation,
  10,
  text: Faker::Lorem.paragraph(sentence_count: 10),
  excerpt: Faker::Lorem.paragraph(sentence_count: 1),
  verse: verse,
  user: ben
)

FactoryBot.create_list(
  :annotation,
  50,
  text: Faker::Lorem.paragraph(sentence_count: 20),
  excerpt: Faker::Lorem.paragraph(sentence_count: 1),
  verse: verse,
  user: erica
)
