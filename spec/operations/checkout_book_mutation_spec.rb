require "rails_helper"

describe "Checkout Book Mutation", :graphql do
  describe "checkoutBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: CheckoutBookInput!) {
          checkoutBook(input: $input) {
            success
            errors {
              message
            }
          }
        }
      GRAPHQL
    end

    it "fails to checkout a book that has already been checked out" do
      book = create(:book)
      user = create(:user)
      create(:rental, book: book, user: user)
      input = {bookId: global_id(book, Outputs::BookType)}

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:checkoutBook][:success]
      expect(success).to be(false)
    end

    it "fails to checkout a book that has been lost" do
      book = create(:book, lost_at: DateTime.now)
      user = create(:user)

      input = {bookId: global_id(book, Outputs::BookType)}

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:checkoutBook][:success]
      expect(success).to be(false)
    end

    it "allows any user to checkout a book" do
      book = create(:book)
      user = create(:user)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: user, variables: {input: input}

      success = result[:data][:checkoutBook][:success]
      expect(success).to be(true)
    end
  end
end
