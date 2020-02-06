class SuspendUserMutation < Types::BaseMutation
  description "Suspend a user"

  argument :user_id, ID, required: true, loads: Outputs::UserType

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    return cannot_suspend_self_error if input.user == current_user
    user = input.user

    if user.suspend
      {user: user, errors: []}
    else
      {user: nil, errors: user.errors}
    end
  end

  def cannot_suspend_self_error
    {user: nil, errors: ["You cannot suspend yourself"]}
  end
end
