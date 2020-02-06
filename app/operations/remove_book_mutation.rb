class RemoveBookMutation < Types::BaseMutation
  description "Removes a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :book, Outputs::BookType, null: true
  field :rentals, [Outputs::RentalType], null: true
  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    result = RemoveBook.new(input.book).call

    if result.success?
      {book: input.book,
       rentals: result.rentals,
       success: true,
       errors: [],}
    else
      {book: nil, success: false, rentals: nil, errors: result.errors}
    end
  end
end
