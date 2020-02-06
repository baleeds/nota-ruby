require "rails_helper"

describe "Rate Book Mutation", :graphql do
  describe "rateBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: RateBookInput!) {
          rateBook(input: $input) {
             success
             errors {
               message
             }
             book {
              averageRating
            }
          }
        }
      GRAPHQL
    end

    it "it allows users to rate a book" do
      book = create(:book)
      user = create(:user)
      input = {
        bookId: global_id(book, Outputs::BookType),
        rating: "EXCELLENT",
      }

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:rateBook][:success]
      expect(success).to be(true)
    end

    it "updates a users existing rating" do
      book = create(:book)
      user = create(:user)
      create(:user_book_rating, user: user, book: book, rating: :poor)
      input = {
        bookId: global_id(book, Outputs::BookType),
        rating: "EXCELLENT",
      }

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:rateBook][:success]
      expect(success).to be(true)
      expect(UserBookRating.first.rating).to eq("excellent")
    end
  end
end
