require "rails_helper"

describe "My Favorite Books Query", :graphql do
  describe "query to see my favorite books" do
    query =
      <<-'GRAPHQL'
        query {
          myFavoriteBooks {
            edges {
              node {
               title
            }
          }
        }
      }
      GRAPHQL

    it "returns all books favorited by the current user" do
      user = create(:user)
      book1 = create(:book)
      book2 = create(:book)
      create(:favorite_book, user: user, book: book1)
      create(:favorite_book, user: user, book: book2)

      result = execute query, as: user

      favorite_books = result[:data][:myFavoriteBooks][:edges].pluck(:node).pluck(:title)

      expect(favorite_books.count).to eq(2)
      expect(favorite_books).to eq([book1.title, book2.title])
    end
  end
end
