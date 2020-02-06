require "rails_helper"

RSpec.describe FavoriteBook, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build_stubbed(:favorite_book)).to be_valid
    end

    it "validates unique index of favorite book" do
      user = create(:user)
      book = create(:book)
      create(:favorite_book, user: user, book: book)

      result = build(:favorite_book, user: user, book: book)

      expect(result).not_to be_valid
    end
  end
end
