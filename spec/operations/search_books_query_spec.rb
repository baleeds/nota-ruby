require "rails_helper"

describe "Search Books Query", :graphql, :search do
  describe "searchBooks" do
    let(:query) do
      <<-'GRAPHQL'
        query($term: String!) {
          searchBooks(term: $term) {
            title
            authors
            description
          }
        }
      GRAPHQL
    end

    it "searches for books by title" do
      create(:book, title: "sup man")
      book = create(:book, title: "hey dude")
      reindex_search(Book)
      term = "hey"

      result = execute query, as: build(:user), variables: {term: term}

      books_result = result[:data][:searchBooks]
      expect(books_result).to include(title: book.title, authors: nil, description: nil)
    end
  end
end
