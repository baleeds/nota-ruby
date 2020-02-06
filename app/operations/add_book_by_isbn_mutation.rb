class AddBookByIsbnMutation < Types::BaseMutation
  description "Adds a book by ISBN"

  argument :isbn, String, required: true

  field :book, Outputs::BookType, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    result = AddBookByIsbn.new(input.isbn).call

    if result.success?
      {
        book: result.book,
        errors: [],
      }
    else
      {book: nil, errors: result.errors}
    end
  end
end
