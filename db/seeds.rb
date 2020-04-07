# frozen_string_literal: true

require 'factory_bot_rails'
require 'faker'
require 'csv'

ben = User.create(
  email: 'ben@gmail.com',
  password: 'Tester12',
  username: 'ben.leeds',
  display_name: 'Ben Leeds',
  admin: true
)

erica = User.create(
  email: 'erica@gmail.com',
  password: 'Tester12',
  username: 'erica.leeds',
  display_name: 'Erica Leeds',
  admin: false
)

csv_text = File.read(Rails.root.join('db', 'assets', 't_web.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
csv.each do |row|
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
  verse: verse,
  user: ben
)

FactoryBot.create_list(
  :annotation,
  50,
  text: Faker::Lorem.paragraph(sentence_count: 20),
  verse: verse,
  user: erica
)
