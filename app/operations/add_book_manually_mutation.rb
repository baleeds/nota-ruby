class AddBookManuallyMutation < Types::BaseMutation
  description "Adds a book manually"

  argument :title, String, required: true
  argument :authors, String, required: false
  argument :description, String, required: false
  argument :image_url, String, required: false
  argument :publisher, String, required: false
  argument :page_count, Integer, required: false

  field :book, Outputs::BookType, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    book = Book.create(input.to_h)
    if book
      {book: book, errors: []}
    else
      {book: nil, errors: book.errors}
    end
  end
end
