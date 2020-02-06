class MyFavoriteBooksQuery < Types::BaseResolver
  description "Gets all of my favorite books"
  type Outputs::BookType.connection_type, null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Book.favorite_for_user(current_user)
  end
end
