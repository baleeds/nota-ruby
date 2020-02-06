require "rails_helper"

describe "Add Book by ISBN", :graphql do
  describe "addBookByISBN" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: AddBookByIsbnInput!) {
          addBookByIsbn(input: $input) {
             book {
               title
            }
          }
        }
      GRAPHQL
    end

    it "properly returns and adds a book by ISBN" do
      stub_const("BookGateway::Http", BookGateway::Test)
      user = create(:user, :admin)
      great_gatsby_isbn = "9780743246392"

      result = execute query, as: user, variables: {input: {isbn: great_gatsby_isbn}}

      book = result[:data][:addBookByIsbn][:book]
      expect(book).not_to be_nil
      expect(book).to include(title: "The Great Gatsby")
    end
  end
end
