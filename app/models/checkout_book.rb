class CheckoutBook
  def initialize(book:, user:)
    @book = book
    @user = user
  end

  def call
    return unavailable_book_error if book.lost? || book.removed?
    return checked_out_book_error if book.checked_out?

    do_checkout
  end

  private

  attr_reader :book, :user

  def do_checkout
    rental = Rental.new(book: book, user: user)

    if rental.save
      update_book(rental)
    else
      Result.failure("Something went wrong creating Rental record")
    end
  end

  def update_book(rental)
    if book.update(rental_id: rental.id)
      Result.success(rental: rental, book: book)
    else
      Result.failure("Something went wrong updating the book")
    end
  end

  def unavailable_book_error
    Result.failure("Book is lost or no longer available")
  end

  def checked_out_book_error
    Result.failure("Book is already checked out")
  end
end
