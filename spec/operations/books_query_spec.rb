require "rails_helper"

describe "Books Query", :graphql do
  describe "query books for title" do
    query =
      <<-'GRAPHQL'
        query($sortBy: BookSortByType, $sortDirection: SortDirectionType) {
          books(sortBy: $sortBy, sortDirection: $sortDirection) {
            edges {
              node {
                title
              }
            }
          }
        }
      GRAPHQL
    it "returns a list of books" do
      book = create(:book, title: "Traction")

      result = execute query, as: build(:user)

      books_result = result[:data][:books][:edges].pluck(:node)
      expect(books_result).to include(title: book.title)
    end

    it "returns a list of non-removed non-lost books" do
      active_book = create(:book)
      lost_book = create(:book, lost_at: now)
      removed_book = create(:book, removed_at: now)

      result = execute query, as: build(:user)

      books_result = result[:data][:books][:edges].pluck(:node)
      expect(books_result).to include(title: active_book.title)
      expect(books_result).not_to include(title: lost_book.title)
      expect(books_result).not_to include(title: removed_book.title)
    end

    it "can sort the books" do
      second_book = create(:book, title: "b")
      first_book = create(:book, title: "a")

      result = execute query, as: build(:user), variables: {
        sortBy: "TITLE",
        sortDirection: "ASC",
      }

      edges = result[:data][:books][:edges]
      expect(edges.first[:node][:title]).to eq(first_book.title)
      expect(edges.second[:node][:title]).to eq(second_book.title)
    end
  end

  describe "query books for average rating" do
    query =
      <<-'GRAPHQL'
        query($sortBy: BookSortByType, $sortDirection: SortDirectionType) {
          books(sortBy: $sortBy, sortDirection: $sortDirection) {
            edges {
              node {
                title
                averageRating
              }
            }
          }
        }
      GRAPHQL
    it "averages all of the ratings for each book" do
      book = create(:book, title: "a")
      create(:book, title: "b")
      create(:user_book_rating, book: book, rating: 4)
      create(:user_book_rating, book: book, rating: 2)

      result = execute query, as: build(:user)

      edges = result[:data][:books][:edges]

      expect(edges.first[:node][:averageRating]).to be(3.0)
      expect(edges.last[:node][:averageRating]).to eq(nil)
    end
  end

  describe "books isFavoritedByMe" do
    query =
      <<-'GRAPHQL'
        query($sortBy: BookSortByType, $sortDirection: SortDirectionType) {
          books(sortBy: $sortBy, sortDirection: $sortDirection) {
            edges {
              node {
                isFavoritedByMe
                }
              }
            }
          }
      GRAPHQL

    it "returns true when the current user has favorited the book" do
      user = create(:user)
      create(:favorite_book, user: user)

      result = execute query, as: user

      edges = result[:data][:books][:edges]

      expect(edges.first[:node][:isFavoritedByMe]).to be(true)
    end
  end

  describe "query books for my rating" do
    query =
      <<-'GRAPHQL'
        query($sortBy: BookSortByType, $sortDirection: SortDirectionType) {
          books(sortBy: $sortBy, sortDirection: $sortDirection) {
            edges {
              node {
                title
                averageRating
                myRating
              }
            }
          }
        }
      GRAPHQL
    it "returns my rating for each book" do
      current_user = create(:user)
      book = create(:book)
      create(:user_book_rating, user: current_user, book: book, rating: 4)
      create(:user_book_rating, book: book, rating: 2)

      result = execute query, as: current_user

      edges = result[:data][:books][:edges]

      expect(edges.first[:node][:averageRating]).to eq(3.0)
      expect(edges.first[:node][:myRating]).to eq(4.0)
    end
  end

  def now
    DateTime.now
  end
end
