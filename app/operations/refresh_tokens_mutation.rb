# frozen_string_literal: true

class RefreshTokensMutation < Types::BaseMutation
  description <<~DESC
    When an access token expires this mutation should be hit with a valid
    refresh token. It will issue a new access token and a new refresh token.
  DESC

  argument :refresh_token, String, required: true

  field :user, Outputs::UserType, null: true
  field :access_token, String, null: true
  field :refresh_token, String, null: true
  field :errors, function: Resolvers::Error.new

  def resolve
    result = RefreshTokens.new(input.refresh_token).call

    if result.success?
      {
        user: result.user,
        access_token: result.access_token,
        refresh_token: result.refresh_token,
        errors: []
      }
    else
      { user: nil, access_token: nil, refresh_token: nil, errors: result.errors }
    end
  end
end
