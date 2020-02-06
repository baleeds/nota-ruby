class SignInUserMutation < Types::BaseMutation
  description "Sign the user in"

  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Outputs::UserType, null: true
  field :access_token, String, null: true
  field :refresh_token, String, null: true
  field :errors, function: Resolvers::Error.new

  def resolve
    result = CredentialAuthentication.new(email: input.email, password: input.password).authenticate

    if result.success?
      {
        user: result.user,
        access_token: result.access_token,
        refresh_token: result.refresh_token,
        errors: [],
      }
    else
      {user: nil, access_token: nil, refresh_token: nil, errors: result.errors}
    end
  end
end
