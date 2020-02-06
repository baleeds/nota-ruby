require "rails_helper"

RSpec.describe RemoveBook do
  describe "#call" do
    it "successfully removes a book and its rentals" do
      book = create(:book, title: "test-title")
      rental = create(:rental, book: book)

      result = described_class.new(book).call

      expect(result.success?).to be(true)
      expect(rental.reload.returned_at).to_not be(nil)
    end
    it "successfully removes the book and returns the rentals" do
      book = create(:book, title: "test-title")
      create(:rental, book: book)
      create(:rental, book: book)

      result = described_class.new(book).call

      expect(result.rentals.length).to eq(2)
    end
  end
  describe "#remove rental" do
    it "finds a books active rental and updates the returned at to now" do
      book = create(:book, title: "test-title")
      rental = create(:rental, book: book)

      result = described_class.new(book).remove_rental(book)

      expect(result.success?).to be(true)
      expect(rental.reload.returned_at).to_not be(nil)
    end
  end
end
