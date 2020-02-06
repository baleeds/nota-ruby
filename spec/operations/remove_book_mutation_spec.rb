require "rails_helper"

describe "Remove Book Mutation", :graphql do
  describe "removeBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: RemoveBookInput!) {
          removeBook(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it "it only allows an admin user to remove a book" do
      book = create(:book)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: build_stubbed(:user, :admin), variables: {input: input}

      success = result[:data][:removeBook][:success]
      expect(success).to be(true)
    end

    it "removes the book and any active rentals concerning that book" do
      book = create(:book)
      create(:rental, book: book)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: build_stubbed(:user, :admin), variables: {input: input}

      success = result[:data][:removeBook][:success]
      expect(success).to be(true)
      expect(book.active_rentals).to eq([])
    end
  end
end
