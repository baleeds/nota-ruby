require "rails_helper"

describe "Return Book Mutation", :graphql do
  describe "returnBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: ReturnBookInput!) {
          returnBook(input: $input) {
            success
            errors {
              message
            }
          }
        }
      GRAPHQL
    end

    it "returns a previously checked out book" do
      book = create(:book)
      user = create(:user)
      create(:rental, book: book, user: user)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:returnBook][:success]
      expect(success).to be(true)
      expect(Rental.first.returned_at?).to_not be(nil)
    end
  end
end
