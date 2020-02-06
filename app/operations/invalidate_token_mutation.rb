class InvalidateTokenMutation < Types::BaseMutation
  description "Invalidates a user's token"

  argument :user_id, ID, required: true, loads: Outputs::UserType

  field :success, Boolean, null: false
  field :errors, function: Resolvers::Error.new, null: false

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    return cannot_invalidate_self_error if input.user == current_user

    if input.user.increment(:token_version)
      {success: true, errors: []}
    else
      {user: nil, errors: user.errors}
    end
  end

  def cannot_invalidate_self_error
    {user: nil, errors: ["You cannot invalidate your own token"]}
  end
end
