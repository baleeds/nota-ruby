class ReturnBookMutation < Types::BaseMutation
  description "Returns a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    rental = Rental.active.find_by!(user: current_user, book: input.book, returned_at: nil)

    if rental.update(returned_at: DateTime.now)
      {success: true, book: input.book, errors: []}
    else
      {success: false, errors: rental.errors}
    end
  end
end
