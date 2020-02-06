require "rails_helper"

describe UserBookRating, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build_stubbed(:user_book_rating)).to be_valid
    end

    it "validates unique index of rate book" do
      user = create(:user)
      book = create(:book)
      create(:user_book_rating, user: user, book: book, rating: :ok)

      result = build(:user_book_rating, user: user, book: book)

      expect(result).not_to be_valid
    end
  end
end
