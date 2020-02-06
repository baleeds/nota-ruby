class UsersQuery < Types::BaseResolver
  description "Get all users"
  type Outputs::UserType.connection_type, null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    User.all
  end
end
