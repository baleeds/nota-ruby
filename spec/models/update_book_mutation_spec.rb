require "rails_helper"

describe "Update Book Mutation API", :graphql do
  describe "updateBook" do
    query =
      <<~'GRAPHQL'
        mutation($input: UpdateBookInput!) {
          updateBook(input: $input) {
             book {
               title
            }
          }
        }
      GRAPHQL

    it "updates a books title" do
      book = create(:book, title: "Chase's Book")
      params = {
        title: "Chase's Updated Book",
      }

      result = execute query, as: build_stubbed(:user, :admin),
                              variables: {input: {bookId: global_id(book, Outputs::BookType), bookInput: params}}

      book = result[:data][:updateBook][:book]

      expect(book[:title]).to eq(params[:title])
    end
  end

  describe "updateBook all fields" do
    query =
      <<~'GRAPHQL'
        mutation($input: UpdateBookInput!) {
          updateBook(input: $input) {
             book {
               authors
               imageUrl
               description
               publisher
               pageCount
            }
          }
        }
      GRAPHQL

    it "updates all of the other params on a book" do
      params = {
        authors: "author 1, author2",
        imageUrl: "http://imageurl.com",
        description: "a description",
        publisher: "A Publisher",
        pageCount: 20,
      }
      book = create(:book, title: "Chase's Book")

      result = execute query, as: build_stubbed(:user, :admin),
                              variables: {input: {bookId: global_id(book, Outputs::BookType), bookInput: params}}

      book = result[:data][:updateBook][:book]
      expect(book).to include(params)
    end
  end
end
