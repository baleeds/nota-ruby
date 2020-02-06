class UpdatePasswordMutation < Types::BaseMutation
  description "Updates the password of the current user"

  argument :current_password, String, required: true
  argument :new_password, String, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    if current_user.update_password(current: input.current_password, new: input.new_password)
      {user: current_user, errors: []}
    else
      {user: nil, errors: ["Password failed to update"]}
    end
  end
end
