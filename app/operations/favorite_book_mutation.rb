class FavoriteBookMutation < Types::BaseMutation
  description "Favorites a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    favorite_book = FavoriteBook.new(user: current_user, book: input.book)

    if favorite_book.save
      {success: true, errors: []}
    else
      {success: false, errors: favorite_book.errors}
    end
  end
end
