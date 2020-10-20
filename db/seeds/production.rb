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
csv.each do |row|
  t = Verse.new
  t.id = row['id']
  t.book_number = row['b']
  t.chapter_number = row['c']
  t.verse_number = row['v']
  t.text = row['t']
  t.save
end