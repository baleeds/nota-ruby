require "rails_helper"

describe BookSearch, :search do
  describe "#search" do
    it "searches on book title" do
      book = create(:book, title: "John")
      reindex_search(Book)
      search = described_class.new(term: "Joh")

      results = search.results

      expect(results.first).to eq(book)
    end

    it "searches on book author" do
      book = create(:book, title: "The Black", authors: "Knight")
      reindex_search(Book)
      search = described_class.new(term: "Knigh")

      results = search.results

      expect(results.first).to eq(book)
    end

    it "searches on book description" do
      book = create(:book, title: "Monty Python", description: "The knights who say Nee!")
      reindex_search(Book)
      search = described_class.new(term: "knights")

      results = search.results

      expect(results.first).to eq(book)
    end

    it "does not return lost or removed books" do
      book = create(:book, title: "John")
      create(:book, lost_at: now)
      create(:book, removed_at: now)
      reindex_search(Book)
      search = described_class.new(term: "Joh")

      results = search.results

      expect(results.first).to eq(book)
      expect(results.count).to eq(1)
    end
  end

  def now
    DateTime.now
  end
end
