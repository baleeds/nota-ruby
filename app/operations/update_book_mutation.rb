class UpdateBookMutation < Types::BaseMutation
  description "Updates a book"

  argument :book_id, ID, required: true, loads: Outputs::BookType
  argument :book_input, Inputs::Book, required: true

  field :book, Outputs::BookType, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    if input.book.update(input.book_input.to_h)
      {
        book: input.book,
        errors: [],
      }
    else
      {book: nil, errors: input.book.errors}
    end
  end
end
