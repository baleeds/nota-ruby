require "rails_helper"

describe "Book Query", :graphql do
  describe "book query" do
    query =
      <<-'GRAPHQL'
        query($bookId: ID!) {
          book(bookId: $bookId) {
            id
          }
        }
      GRAPHQL

    it "return the specified book" do
      book = create(:book)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book]).to include(id: book_id)
    end
  end

  describe "isCurrentlyCheckedOut field" do
    query =
      <<-'GRAPHQL'
        query($bookId: ID!) {
          book(bookId: $bookId) {
            isCurrentlyCheckedOut
          }
        }
      GRAPHQL

    it "returns true when the current book is checked out at all" do
      book = create(:book)
      create(:rental, book: book)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book]).to include(isCurrentlyCheckedOut: true)
    end

    it "returns false when the current book is not checked out at all" do
      book = create(:book)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book]).to include(isCurrentlyCheckedOut: false)
    end
  end

  describe "isCurrentlyCheckedOutByMe field" do
    query =
      <<-'GRAPHQL'
        query($bookId: ID!) {
          book(bookId: $bookId) {
            isCurrentlyCheckedOutByMe
          }
        }
      GRAPHQL

    it "returns true when the user has checked out the book" do
      book = create(:book)
      user = create(:user)
      create(:rental, book: book, user: user)

      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: user, variables: {
        bookId: book_id,
      }

      expect(result[:data][:book]).to include(isCurrentlyCheckedOutByMe: true)
    end

    it "returns false when the user has not checked out the book" do
      book = create(:book)
      user = create(:user)
      create(:rental, book: book)

      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: user, variables: {
        bookId: book_id,
      }

      expect(result[:data][:book]).to include(isCurrentlyCheckedOutByMe: false)
    end
  end

  describe "rental field" do
    query =
      <<-'GRAPHQL'
        query($bookId: ID!) {
          book(bookId: $bookId) {
            rental {
              returnedAt
            }
          }
        }
      GRAPHQL

    it "returns only the latest active rental on a book when queried as an admin" do
      book = create(:book)
      create(:rental, book: book, returned_at: now)
      create(:rental, book: book, returned_at: nil)
      create(:rental)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user, admin: true), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book][:rental]).to include(returnedAt: nil)
    end

    it "returns nil if the current user is not an admin" do
      book = create(:book)
      create(:rental, book: book, returned_at: nil)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user, admin: false), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book][:rental]).to be(nil)
    end
  end
  describe "rental field" do
    query =
      <<-'GRAPHQL'
        query($bookId: ID!) {
          book(bookId: $bookId) {
            rental {
              checkedOutBy {
                email
              }
            }
          }
        }
      GRAPHQL

    it "returns by whom the book was checked out" do
      book = create(:book)
      user = create(:user, email: "chase@chase.com")
      create(:rental, book: book, user: user)
      book_id = global_id(book, Outputs::BookType)

      result = execute query, as: build(:user, admin: true), variables: {
        bookId: book_id,
      }

      expect(result[:data][:book][:rental])
        .to include(checkedOutBy: {email: user.email})
    end
  end

  def now
    DateTime.now
  end
end
