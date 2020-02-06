class CheckoutBookMutation < Types::BaseMutation
  description "Checksout a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    result = CheckoutBook.new(book: input.book, user: current_user).call

    if result.success?
      {success: true, errors: []}
    else
      {success: false, errors: result.errors}
    end
  end
end
