class RefreshTokens
  def initialize(token_string)
    @token_string = token_string
  end

  def call
    decoded_token = RefreshToken.decode(token_string)

    if decoded_token.valid?
      user = decoded_token.user
      Result.success(
        user: user,
        access_token: AccessToken.issue(user),
        refresh_token: RefreshToken.issue(user)
      )
    else
      Result.failure(["Invalid refresh token"])
    end
  end

  private

  attr_reader :token_string
end
