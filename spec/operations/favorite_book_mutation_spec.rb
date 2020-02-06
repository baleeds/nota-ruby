require "rails_helper"

describe "Favorite Book Mutation", :graphql do
  describe "favoriteBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: FavoriteBookInput!) {
          favoriteBook(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it "allows a user to mark a book as their favorite" do
      book = create(:book)
      user = create(:user)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:favoriteBook][:success]
      expect(success).to be(true)
    end
  end
end
