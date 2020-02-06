class AdminCheckedOutBooksQuery < Types::BaseResolver
  description "Admins can see all books that are currently checked out"
  type Outputs::BookType.connection_type, null: false
  policy ApplicationPolicy, :admin?

  def authorized_resolve
    Book.latest_checked_out
  end
end
