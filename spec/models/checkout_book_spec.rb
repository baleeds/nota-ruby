require "rails_helper"

RSpec.describe CheckoutBook do
  describe "#call" do
    it "successfully checks out a book who's last rental record was returned" do
      user = create(:user)
      book = create(:book, title: "test-title")
      create(:rental, user: user, book: book, returned_at: now)

      result = described_class.new(user: user, book: book).call

      expect(result.success?).to be(true)
    end

    it "fails to checkout a book that is lost" do
      user = create(:user)
      lost_book = create(:book, title: "test-title", lost_at: now)

      result = described_class.new(user: user, book: lost_book).call

      expect(result.success?).to be(false)
    end

    it "fails to checkout a book that's already checked out" do
      user = create(:user)
      book = create(:book, title: "test-title")
      create(:rental, user: user, book: book, returned_at: nil)

      result = described_class.new(user: user, book: book).call

      expect(result.success?).to be(false)
    end
  end

  private

  def now
    DateTime.now
  end
end
