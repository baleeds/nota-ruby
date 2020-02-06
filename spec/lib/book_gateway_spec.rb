require "rails_helper"

describe BookGateway do
  describe "BookGateway Contract", ci_only: true do
    it "does not diverge from the actual api call" do
      great_gatsby_isbn = "9780743246392"

      real_book = BookGateway::Http.find_by_isbn(great_gatsby_isbn)
      fake_book = BookGateway::Test.find_by_isbn(great_gatsby_isbn)

      important_keys = fake_book.to_h.keys

      important_keys.each { |key| expect(real_book.respond_to?(key)).to be(true) }
    end
  end
end
