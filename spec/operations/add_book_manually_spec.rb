require "rails_helper"

describe "Add Book Manually", :graphql do
  describe "addBookManually" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: AddBookManuallyInput!) {
          addBookManually(input: $input) {
             book {
               title
               authors
               description
               imageUrl
               publisher
               pageCount
            }
          }
        }
      GRAPHQL
    end

    it "properly returns and adds a book manually" do
      book_input = {
        title: "Chase's New Book",
      }

      result = execute query, as: build_stubbed(:user, :admin), variables: {input: book_input}

      book = result[:data][:addBookManually][:book]
      expect(book[:title]).to eq(book_input[:title])
      expect(Book.count).to eq(1)
    end
  end
end
