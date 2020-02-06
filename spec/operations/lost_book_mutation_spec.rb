require "rails_helper"

describe "Lost Book Mutation", :graphql do
  describe "lostBook" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: LostBookInput!) {
          lostBook(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it "it only allows an admin user to mark a book as lost" do
      book = create(:book)
      input = {
        bookId: global_id(book, Outputs::BookType),
      }

      result = execute query, as: build_stubbed(:user, :admin), variables: {input: input}

      success = result[:data][:lostBook][:success]
      expect(success).to be(true)
    end
  end
end
