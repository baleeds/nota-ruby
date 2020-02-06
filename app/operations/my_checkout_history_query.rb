class MyCheckoutHistoryQuery < Types::BaseResolver
  description "Gets all the books"
  type Outputs::RentalType.connection_type, null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Rental.for_user(context[:current_user]).latest
  end
end
