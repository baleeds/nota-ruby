class RemoveBook
  def initialize(book)
    @book = book
  end

  def call
    if book.update(removed_at: DateTime.now)
      remove_rental(book)
    else
      Result.failure(book.errors)
    end
  end

  def remove_rental(book)
    rentals = book.active_rentals
    if rentals.update(returned_at: DateTime.now)
      Result.success(book: book, rentals: rentals)
    else
      Result.failure("rentals could not be removed")
    end
  end

  private

  attr_reader :book
end
