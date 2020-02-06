class MyCheckedOutBooksQuery < Types::BaseResolver
  description "Gets all the books"
  type Outputs::RentalType.connection_type, null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Rental.active.for_user(context[:current_user])
  end
end
