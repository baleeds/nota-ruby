class UnfavoriteBookMutation < Types::BaseMutation
  description "Unfavorites a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    favorite_book = FavoriteBook.find_by!(user: current_user, book: input.book)
    favorite_book.destroy

    {success: favorite_book.destroyed?, errors: favorite_book.errors}
  end
end
