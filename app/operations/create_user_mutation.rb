# frozen_string_literal: true

class CreateUserMutation < Types::BaseMutation
  description 'Admin ability to create a user'

  argument :email, String, required: true
  argument :is_admin, Boolean, required: true, as: :admin
  argument :username, String, required: true
  argument :display_name, String, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :admin?

  def authorized_resolve
    result = CreateUser.new(input.to_h).call
    if result.success?
      { user: result.user, errors: [] }
    else
      { user: nil, errors: result.errors }
    end
  end
end
