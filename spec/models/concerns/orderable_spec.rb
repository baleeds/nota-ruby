require "rails_helper"

RSpec.describe "Ordering model", type: :model do
  class Book < ApplicationRecord
    include Orderable

    scope :order_by_title, ->(direction) {
      order(title: direction)
    }
  end

  describe ".order_by" do
    it "orders by a scope" do
      second_record = create(:book, title: "b")
      third_record = create(:book, title: "c")
      first_record = create(:book, title: "a")

      ordered = Book.order_by(:title, :asc)

      expect(ordered).to eq([first_record, second_record, third_record])
    end

    it "falls through to a column if the scope does not exist" do
      second_record = create(:book, authors: "b")
      first_record = create(:book, authors: "a")
      third_record = create(:book, authors: "c")

      ordered = Book.order_by(:authors, :asc)

      expect(ordered).to eq([first_record, second_record, third_record])
    end
  end
end
