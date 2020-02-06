require "rails_helper"

RSpec.describe AddBookByIsbn do
  describe ".call" do
    it "returns the first book found with the isbn number, and checks to make sure a book was created" do
      isbn = "9781504926003"

      fake_gateway = BookGateway::Test

      book = AddBookByIsbn.new(isbn, gateway: fake_gateway).call

      expect(book).to_not be_nil
      expect(Book.first[:title]).to eql("The Great Gatsby")
    end

    it "fails when book is not found" do
      isbn = nil

      fake_gateway = BookGateway::Test

      result = AddBookByIsbn.new(isbn, gateway: fake_gateway).call

      expect(result.success?).to be(false)
      expect(Book.first).to be_nil
    end

    it "can add the same book twice" do
      isbn = "9781504926003"
      fake_gateway = BookGateway::Test

      book = AddBookByIsbn.new(isbn, gateway: fake_gateway).call
      book2 = AddBookByIsbn.new(isbn, gateway: fake_gateway).call

      expect(book).to_not be_nil
      expect(book2).to_not be_nil
      expect(Book.count).to eq(2)
    end
  end
end
