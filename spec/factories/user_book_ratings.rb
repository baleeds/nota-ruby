FactoryBot.define do
  factory :user_book_rating do
    user
    book
    rating { [:terrible, :poor, :ok, :good, :excellent].sample }
  end
end
