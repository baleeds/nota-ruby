class BookQuery < Types::BaseResolver
  description "Gets all the books"
  type Outputs::BookType, null: false
  argument :book_id, ID, required: true, loads: Outputs::BookType
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    input.book
  end
end
