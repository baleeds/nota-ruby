require "rails_helper"

describe "Unfavorite Book Mutation", :graphql do
  describe "unfavoriteBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: UnfavoriteBookInput!) {
          unfavoriteBook(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it "allows a user to unfavorite a book" do
      favorite_book = create(:favorite_book)
      input = {bookId: global_id(favorite_book.book, Outputs::BookType)}

      result = execute query, as: favorite_book.user, variables: {input: input}

      success = result[:data][:unfavoriteBook][:success]
      expect(success).to be(true)
    end
  end
end
