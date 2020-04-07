# frozen_string_literal: true

class UnsuspendUserMutation < Types::BaseMutation
  description 'Unsuspend a user'

  argument :user_id, ID, required: true, loads: Outputs::UserType

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    user = input.user

    if user.unsuspend
      { user: user, errors: [] }
    else
      { user: nil, errors: user.errors }
    end
  end
end
