class BooksQuery < Types::BaseResolver
  description "Gets all the books"
  argument :sort_by,
    Types::BookSortByType,
    "The column to sort the results by",
    default_value: :title,
    required: false
  argument :sort_direction,
    Types::SortDirectionType,
    "The direction to sort the results",
    default_value: :asc,
    required: false
  type Outputs::BookType.connection_type, null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Book.active.order_by(input.sort_by, input.sort_direction)
  end
end
