require "rails_helper"

RSpec.describe Book, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build(:book)).to be_valid
    end

    it { should validate_presence_of(:title) }
  end

  describe ".active" do
    it "returns books that are not lost or removed" do
      book_count = 2
      book_count.times { create(:book) }
      lost_book = create(:book, lost_at: now)
      removed_book = create(:book, removed_at: now)

      books = Book.active

      expect(books).to_not include(lost_book)
      expect(books).to_not include(removed_book)
      expect(books.count).to be(book_count)
    end
  end

  describe ".checked_out" do
    it "only returns books that are checked out" do
      returned_book = create(:book)
      create(:rental)
      create(:rental, book: returned_book, returned_at: now)

      books = Book.checked_out

      expect(books).to_not include(returned_book)
      expect(books.count).to be(1)
    end
  end

  describe ".latest_checked_out" do
    it "returns books that have been checked out sorted by most recent (checkout) date" do
      returned_book = create(:book)
      create(:rental, book: returned_book, returned_at: now)
      third = create(:book)
      second = create(:book)
      first = create(:book)
      create(:rental, book: second, created_at: 3.years.ago)
      create(:rental, book: first, created_at: 2.years.ago)
      create(:rental, book: third, created_at: 4.years.ago)

      books = Book.latest_checked_out

      expect(books).to_not include(returned_book)
      expect(books.count).to be(3)
      expect(books).to eq([first, second, third])
    end
  end

  describe ".favorite_for_user" do
    it "returns books favorited by that user" do
      book = create(:book)
      user = create(:user)
      create(:favorite_book, book: book, user: user)
      different_favorited_book = create(:favorite_book)

      books = Book.favorite_for_user(user)

      expect(books).to_not include(different_favorited_book)
      expect(books.count).to be(1)
      expect(books.first).to eq(book)
    end
  end

  describe "#checked_out?" do
    it "returns true when a book is indeed checked_out" do
      user = create(:user)
      book = create(:book)
      create(:rental, book: book, user: user, returned_at: nil)

      result = book.checked_out?

      expect(result).to be(true)
    end

    it "returns false when a book is not checked_out" do
      user = create(:user)
      book = create(:book)
      create(:rental, book: book, user: user, returned_at: now)

      result = book.checked_out?

      expect(result).to be(false)
    end
  end

  describe "#currently_checked_out_by_user?" do
    it "checks if the provided user has checked out that book" do
      book = create(:book)
      user = create(:user)
      create(:rental, book: book, user: user)

      result = book.currently_checked_out_by_user?(user)

      expect(result).to be(true)
    end

    it "checks if the provided user has checked out that book" do
      book = create(:book)
      user = create(:user)
      current_user = create(:user)
      create(:rental, book: book, user: user)

      result = book.currently_checked_out_by_user?(current_user)

      expect(result).to be(false)
    end
  end

  describe "#average_rating" do
    it "returns the average rating of all created user ratings for a book" do
      book = create(:book)
      create(:user_book_rating, book: book, rating: 4)
      create(:user_book_rating, book: book, rating: 2)
      create(:user_book_rating, rating: 5)

      result = book.average_rating

      expect(result).to be(3)
    end
  end

  describe "#rating_for_user" do
    it "it returns the rating given by a specific user on a given book" do
      book = create(:book)
      user = create(:user)
      create(:user_book_rating, user: user, book: book, rating: 4)
      create(:user_book_rating, book: book, rating: 2)
      my_rating = 4
      book_average_rating = 3

      result = book.rating_for_user(user)

      expect(result).to_not eq(book_average_rating)
      expect(result).to eq(my_rating)
    end
  end

  describe "#favorited?" do
    it "returns true when a book is favorited" do
      book = create(:book)
      user = create(:user)
      create(:favorite_book, user: user, book: book)

      result = book.favorited?(user)

      expect(result).to be(true)
    end

    it "returns false when a book is favorited" do
      book = create(:book)
      user = create(:user)

      result = book.favorited?(user)

      expect(result).to be(false)
    end
  end

  describe "#lost?" do
    it "returns true when a book is not lost" do
      book = create(:book, lost_at: now)

      result = book.lost?

      expect(result).to be(true)
    end

    it "returns false when a book is not lost" do
      book = create(:book, lost_at: nil)

      result = book.lost?

      expect(result).to be(false)
    end
  end

  describe "#latest_rental" do
    it "returns the latest active rental" do
      book = create(:book)
      create(:rental, book: book, returned_at: now)
      create(:rental, book: book, returned_at: now)
      create(:rental, book: book, returned_at: nil)
      active_rental = create(:rental, book: book, returned_at: nil)

      result = book.latest_rental

      expect(result).to eq(active_rental)
    end
  end

  describe "#removed?" do
    it "returns true when a book is removed" do
      book = create(:book, removed_at: now)

      result = book.removed?

      expect(result).to be(true)
    end

    it "returns false when a book is not removed" do
      book = create(:book, removed_at: nil)

      result = book.removed?

      expect(result).to be(false)
    end
  end

  def now
    DateTime.now
  end
end
