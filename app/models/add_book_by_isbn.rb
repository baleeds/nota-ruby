class AddBookByIsbn
  def initialize(isbn, gateway: BookGateway::Http)
    @isbn = isbn
    @gateway = gateway
  end

  def call
    book = gateway.find_by_isbn(isbn)
    if book
      insert_book(book)
    else
      Result.failure({field: :isbn, message: "Book was not found"})
    end
  end

  private

  attr_reader :isbn, :gateway

  def insert_book(book)
    inserted_book = Book.new({
      title: book.title,
      authors: book.authors,
      description: book.description,
      image_url: book.image_link,
      page_count: book.page_count,
      publisher: book.publisher,
      isbn: isbn,
    })
    if inserted_book.save
      Result.success(book: inserted_book)
    else
      Result.failure(inserted_book.errors)
    end
  end
end
