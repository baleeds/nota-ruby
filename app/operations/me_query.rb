class MeQuery < Types::BaseResolver
  description "Returns the currently logged in user"
  type Outputs::UserType, null: true
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    current_user
  end
end
