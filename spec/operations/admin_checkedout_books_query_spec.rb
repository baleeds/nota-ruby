require "rails_helper"

describe "Admin checked out books query", :graphql do
  describe "checkedOutBooks" do
    let(:query) do
      <<-'GRAPHQL'
        query {
          checkedOutBooks {
            edges {
              node {
                title
              }
            }
          }
        }
      GRAPHQL
    end

    it "returns a list of books" do
      create(:book, title: "Not Checked Out Book")
      book = create(:book, title: "Checked Out Book")
      create(:rental, book: book)

      result = execute query, as: build(:user, admin: true)

      edges = result[:data][:checkedOutBooks][:edges]
      books_result = edges.pluck(:node)
      expect(books_result).to include(title: book.title)
      expect(edges.count).to be(1)
    end
  end
end
