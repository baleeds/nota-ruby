class UserQuery < Types::BaseResolver
  description "Return the specified user"
  type Outputs::UserType, null: false
  argument :user_id, ID, required: true, loads: Outputs::UserType
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    input.user
  end
end
