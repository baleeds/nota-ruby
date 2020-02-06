class LostBookMutation < Types::BaseMutation
  description "Marks a book as lost"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    if input.book.update(lost_at: DateTime.now)
      {success: true, errors: []}
    else
      {success: false, errors: input.book.errors}
    end
  end
end
